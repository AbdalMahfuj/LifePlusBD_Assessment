

import UIKit
import CoreData

let DBStoreName = "LP DB"


class DBManager: NSObject {
    
    static let shared = DBManager()
    
    private var managedContext : NSManagedObjectContext?
    private var backgroundContext : NSManagedObjectContext?
    private var managedModel : NSManagedObjectModel?
    private var persistentCoordinator : NSPersistentStoreCoordinator?
    
    private override init() {}
    
    
    func insertUser(name: String, userName: String, phone: String, password: String)->Bool {
        guard let moc = managedObjectContext() else {
            return false
        }
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: moc) else {
            return false
        }
        
        guard let user = NSManagedObject(entity: userEntity, insertInto: moc) as? User else {
            return false
        }
        
        user.name = name
        user.phone = phone
        user.userName = userName
        user.password = password
        
        return saveContext(moc)
    }
    
    
    func getAllUsers()->[User] {
        return getData(entity: "User") as! [User]
    }
    
    
    func getUserBy(userName: String)->User? {
        let pred = NSPredicate(format: "userName = %@", userName)
        return getData(entity: "User", predicate: pred).first as? User
    }
    
    
    func getUserBy(userName: String, password: String)->User? {
        let pred = NSPredicate(format: "userName = %@ AND password = %@", userName, password)
        return getData(entity: "User", predicate: pred).first as? User
    }
    
    
    func updateUser(name: String, userName: String, phone: String, password: String)->Bool {
        guard let moc = managedObjectContext() else {
            return false
        }
        
        guard let user = getUserBy(userName: userName) else {
            return false
        }
        
        user.name = name
        user.phone = phone
        user.userName = userName
        user.password = password
        return saveContext(moc)
    }
    
    
    func deleteUser(userName: String)->Bool {
        return deleteData(entity: "User", predicate: NSPredicate(format: "userName = %@", userName))
    }
    
    
    // MARK: - COMMON CRUD -
    
    
    
    // Fetch
    private func getData(entity: String, predicate: NSPredicate? = nil, sorts: [NSSortDescriptor]? = nil)->[AnyObject] {
        guard let moc = managedObjectContext() else { return []  }
        return getData(entity: entity, managed: true, predicate: predicate, sorts: sorts, context: moc)
    }
    
    private func getData(entity: String, managed: Bool, predicate:NSPredicate? = nil, sorts: [NSSortDescriptor]? = nil, context:NSManagedObjectContext) ->[AnyObject]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.includesSubentities = false
        
        var results = [AnyObject]()
        
        if let _ = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let _ = sorts {
            fetchRequest.sortDescriptors = sorts
        }
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            
            if fetchResults.count > 0 {
                
                if managed {
                    for obj in fetchResults {
                        results.append(obj as AnyObject)
                    }
                }
                else{
                    for obj in fetchResults where obj is NSManagedObject {
                        //                        if let eObj = Mapper.convertToEntity(obj as! NSManagedObject){
                        //                            results.append(eObj)
                        //                        }
                        
                        //                        if let eObj = (obj as! NSManagedObject).toEntity() {
                        //                            results.append(eObj)
                        //                        }
                    }
                }
                
            }
            
        } catch {
            print("error")
        }
        
        return results
    }
    
    
    private func getRowCount(entity: String, predicate: NSPredicate? = nil)->Int {
        guard let moc = managedObjectContext() else { return 0 }
        return getRowCount(entity: entity, predicate: predicate, context: moc)
    }
    
    private func getRowCount(entity: String, predicate: NSPredicate? = nil, context:NSManagedObjectContext)-> Int {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fr.includesSubentities = false
        
        if let pred = predicate { fr.predicate = pred }
        
        do {
            let count = try context.count(for: fr)
            return count
        }
        catch {
            print("error")
            return 0
        }
    }
    
    
    // Delete
    
    private func deleteData(entity: String, predicate: NSPredicate? = nil)->Bool{
        guard let moc = managedObjectContext() else {  return  false }
        return deleteData(entity: entity, predicate: predicate, context: moc)
    }
    
    
    private func deleteData(entity: String, predicate: NSPredicate? = nil, context: NSManagedObjectContext)->Bool{
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        if let pred = predicate { fr.predicate = pred }
        
        do {
            let results = try context.fetch(fr)
            
            if results.count > 0{
                for obj in results{
                    let mobj = obj as! NSManagedObject
                    context.delete(mobj)
                }
                
                return saveContext(context)
            }
            else{
                return true
            }
        } catch let error {
            print("deleteData error: \(error.localizedDescription)")
            return false
        }
    }
    
    
    
    // MARK: - CoreData Stack -
    
    private func saveContext(_ context: NSManagedObjectContext)->Bool{
        if context.hasChanges {
            do {
                try context.save()
                return true
            }
            catch{
                print("Unresolved error \(error.localizedDescription)")
                return false
            }
        }
        else {
            return true
        }
    }
    
    
    private func managedObjectContext()-> NSManagedObjectContext?{
        if let moc = managedContext { return moc }
        guard let psc = persistentStoreCoordinator() else{ return  nil }
        
        managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext?.retainsRegisteredObjects = true
        managedContext?.persistentStoreCoordinator = psc
        return  managedContext
    }
    
    
    private func backgroundManagedObjectContext()->NSManagedObjectContext?{
        if let moc = backgroundContext { return moc }
        guard let _ = persistentStoreCoordinator() else { return  nil }
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext?.parent = managedObjectContext()
        return backgroundContext
    }
    
    
    private func persistentStoreCoordinator ()-> NSPersistentStoreCoordinator?{
        if let psc = persistentCoordinator { return psc }
        else {
            let storeURL = applicationStoresDirectory()!.appendingPathComponent("\(DBStoreName).sqlite")
            
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true, NSSQLitePragmasOption: ["journal_mode": "DELETE"]] as [String : Any]
            
            guard let mom = managedObjectModel() else { return nil }
            
            persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
            
            do{
                if let _ =  try persistentCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options) {
                    return persistentCoordinator
                }
                
                let fm = FileManager.default
                
                // Move Incompatible Store
                if fm.fileExists(atPath: storeURL.path){
                    
                    guard let corruptUrl = applicationIncompatibleStoresDirectory() else { return nil }
                    
                    let corruptURL = corruptUrl.appendingPathComponent(nameForIncompatibleStore())
                    
                    // Move Corrupt Store
                    do {
                        try fm.moveItem(at:storeURL, to:corruptURL)
                    }
                    catch{
                        return nil
                    }
                }
                
                
                do{
                    try persistentCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
                }
                catch{
                    print("Unable to create persistent store after recovery. \(error.localizedDescription)");
                    return nil
                }
                
            }
            catch{
                print("Failed to create with SQLite")
                return nil
            }
        }
        
        return persistentCoordinator
    }
    
    private func managedObjectModel()->NSManagedObjectModel?{
        if let mom = managedModel { return mom }
        
        guard let url = Bundle.main.url(forResource: DBStoreName, withExtension: "momd") else {
            managedModel = NSManagedObjectModel .mergedModel(from: nil)
            return managedModel
        }
        
        managedModel = NSManagedObjectModel(contentsOf :url)
        return managedModel
    }
    
    
    private func resetApplicationModel()-> Bool{
        guard var url = applicationStoresDirectory() else { return false }
        
        url = url.appendingPathComponent("\(DBStoreName).sqlite")
        
        let fm = FileManager.default
        
        do {
            try fm.removeItem(at: url)
        }
        catch{
            return false
        }
        
        do {
            let urlString =  try String(contentsOf: url)
            
            if fm.fileExists(atPath: urlString) {
                
                do {
                    try  fm.removeItem(at: url)
                }
                catch{
                    return false
                }
            }
        }
        catch{
            return false
        }
        
        guard let moc = managedObjectContext() else{
            return false
        }
        
        for mo in moc.registeredObjects {
            moc.delete(mo)
        }
        
        managedContext = nil
        persistentCoordinator = nil
        return true
    }
    
    
    private func resetDataStore()->Bool{
        let reset = resetApplicationModel()
        if reset {  _ =  managedObjectContext() }
        return reset
    }
    
    
    private func applicationIncompatibleStoresDirectory()-> URL?{
        let fm = FileManager.default
        guard var url = applicationStoresDirectory() else { return nil }
        
        url = url.appendingPathComponent("Incompatible")
        
        if !(fm.fileExists(atPath: url.path)) {
            do {
                try  fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("Unable to create directory for corrupt data stores.")
                return nil
            }
            
            return url
        }
        else{
            return url
        }
    }
    
    
    private func applicationStoresDirectory()-> URL?{
        let fm = FileManager.default
        let applicationApplicationSupportDirectory = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).last!
        let url = applicationApplicationSupportDirectory.appendingPathComponent("Stores")
        
        if !(fm.fileExists(atPath: url.path)) {
            do {
                try  fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("Unable to create directory for corrupt data stores.")
                return nil
            }
            return url
        }
        else{
            return url
        }
    }
    
    private func nameForIncompatibleStore()-> String {
        let df = DateFormatter()
        df.formatterBehavior = .behavior10_4
        df.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let name = df.string(from: Date.init())
        return name
    }
}



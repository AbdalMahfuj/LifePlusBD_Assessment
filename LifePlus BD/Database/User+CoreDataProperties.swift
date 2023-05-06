//
//  User+CoreDataProperties.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?

}

extension User : Identifiable {

}

//
//  DashboardViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit
import SVProgressHUD
import SkeletonView

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tvshowTableView: UITableView!
    @IBOutlet weak var tvSearchbar: UISearchBar!
    
    private var user: User?
    private var results: [TVShow] = []
    private var isPresent: Bool?
    
    
    class func initVC(user: User)->DashboardViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.user = user
        return vc
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        tvSearchbar.searchTextField.text = "flower"
        fetchTVShow(with: "flower")
    }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func setupUI(){
        tvshowTableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        tvSearchbar.delegate = self
        self.navigationItem.title = "Dashboard"
        
        let logoutButton = UIButton(type: .custom)
        logoutButton.frame = .init(origin: .zero, size: .init(width: 60, height: 35))
        logoutButton.backgroundColor = .clear
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        
        let leftItem = UIBarButtonItem(customView: logoutButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        let profileButton = UIButton(type: .custom)
        profileButton.frame = .init(origin: .zero, size: .init(width: 60, height: 35))
        profileButton.backgroundColor = .clear
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        profileButton.setTitle("Profile", for: .normal)
        profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: profileButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
 
    @objc
    private func logoutPressed() {
        showConfirmAlert(title: "Confirmation", message: "Are you sure, you want to logout?", button: "Logout") {
            UserDefaults.standard.removeObject(forKey: "user_name")
            UserDefaults.standard.synchronize()
            self.gotoLogin()
        }
    }
    
    @objc
    private func profilePressed() {
        let vc = ProfileViewController.initVC(user: user!)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DashboardViewController {
    private func gotoLogin() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navVC = UINavigationController(rootViewController: vc)
        (UIApplication.shared.delegate as! AppDelegate).setRootVC(navVC)
    }
}


extension DashboardViewController {
    private func fetchTVShow(with query: String) {
       // SVProgressHUD.show()
        isPresent = true
        let urlString = "https://api.tvmaze.com/search/shows?q=\(query)"
        
        APIManager.shared.callService(urlString: urlString, method: "GET", body: nil) { [weak self] data in
            DispatchQueue.main.async {
                
             //   SVProgressHUD.dismiss()
                self!.isPresent = false
                
                guard let weakSelf = self else {
                    return
                }
                if let data = data {
                    do {
                        weakSelf.results  = try JSONDecoder().decode([TVShow].self, from: data)
                        weakSelf.tvshowTableView.reloadData()
                        print(weakSelf.results.count)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}

extension DashboardViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
            clear()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        if let text = searchBar.text, text.count > 0 {
            clear()
            fetchTVShow(with: text)
        }
        else {
            clear()
        }
    }
    
    private func clear() {
        results = []
        tvshowTableView.reloadData()
    }
}


extension DashboardViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "ContentTableViewCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.isEmpty ? 5 : results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
        
        if !results.isEmpty {
            cell.hideSkeletonAnimatio()
            cell.setUI(tvshow: results[indexPath.row])
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !results.isEmpty {
            let detailShowVC = DetailShowViewController.initVC(result: results[indexPath.row])
            self.navigationController?.pushViewController(detailShowVC, animated: true)
        }
        
    }
}

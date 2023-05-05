//
//  DashboardViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class DashboardViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tvshowTableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var tvSearchbar: UISearchBar!
    var user: User?
    var results: [TVShow] = []
    
    class func initVC(user: User)->DashboardViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.user = user
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvshowTableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tvshowTableView.delegate = self
        tvshowTableView.dataSource = self
        tvSearchbar.delegate = self
        self.navigationItem.title = "Dashboard"
        self.profileButton.setTitle(self.user?.userName, for: .normal)
    }
   

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchPhoto(with: "flower")
    }
 
   
    
    @IBAction func viewProfilePressed(_ sender: UIButton) {
        
        let vc = ProfileViewController.initVC(user: user!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        clear()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        if let text = searchBar.text, text.count > 0 {
            clear()
            fetchPhoto(with: text)
        }
        else {
            clear()
        }
    }
    
    func clear() {
        results = []
        tvshowTableView.reloadData()
    }
    
    
    private func fetchPhoto(with query: String) {
//        let urlString = "https://api.tvmaze.com/singlesearch/shows?q=\(query)"
        let urlString = "https://api.tvmaze.com/search/shows?q=\(query)"
        
        APIManager.shared.callService(urlString: urlString, method: "GET", body: nil) { [weak self] data in
            guard let weakSelf = self else {
                return
            }
            if let data = data {
                do {
                    weakSelf.results  = try JSONDecoder().decode([TVShow].self, from: data)
                    //                    weakSelf.results = [singleresule]
                    DispatchQueue.main.async {
                        weakSelf.tvshowTableView.reloadData()
                        print(weakSelf.results.count)
                    }
                }
                catch {
                    print(error)
                }
                print("task ok")
            }
        }
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentTableViewCell
        cell.setUI(tvshow: results[indexPath.row])
        return cell
    }
}

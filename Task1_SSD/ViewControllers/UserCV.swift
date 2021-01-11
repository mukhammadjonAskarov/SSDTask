//
//  ViewController.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import UIKit

class UserCV: UIViewController {
    
    var users: [User] = []
    var db: DBHelper  = DBHelper()
    var page          = 0
    var pageSize      = 10
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addUsersButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertUsersToDatabase()
        users  = db.readUserTable(page: page, pageSize: pageSize)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        users  = db.readUserTable(page: page, pageSize: pageSize)
        tableView.reloadData()
    }
    
    func insertUsersToDatabase() {
        
        for n in 0...100 {
            db.insertIntoUser(name: "User-\(n)", createdAt: "\(n)  01.01.2021")
        }
    }

}

extension UserCV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text     = "Name: \(users[indexPath.row].name) Date: \(users[indexPath.row].dateCreatedAt)"
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
        let offSetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.height
        
        if offSetY > contentHeight - height {
            page += 1
            users = users + db.readUserTable(page: page, pageSize: pageSize)
            tableView.reloadData()

        }
        
    }
    
}


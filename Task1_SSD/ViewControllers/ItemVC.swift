//
//  ItemVC.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import UIKit

class ItemVC: UIViewController {
    
    var items: [Items] = []
    var db: DBHelper  = DBHelper()
    var page          = 0
    var pageSize      = 10
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertItemsToDatabase()
        items  = db.readItemsTable(page: page, pageSize: page)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        items  = db.readItemsTable(page: page, pageSize: pageSize)
        tableView.reloadData()
    }
    
    func insertItemsToDatabase() {
        
        for n in 0...100 {
            db.insertIntoItems(name: "Item \(n)")
        }
    }
}

extension ItemVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text     = "Item: \(items[indexPath.row].itemName)"
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offSetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.height
        
        if offSetY > contentHeight - height {
            page += 1
            items = items + db.readItemsTable(page: page, pageSize: pageSize)
            tableView.reloadData()
            
        }
        
    }
    
}

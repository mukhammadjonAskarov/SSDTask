//
//  insertItemVC.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import UIKit

class InsertItemVC: UIViewController {
    
    var itemName: String = ""
    var db: DBHelper = DBHelper()
    
    @IBOutlet var itemNameTextField: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        
        if itemNameTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Need info", message: "All fields are required", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        itemName = itemNameTextField.text!
        db.insertIntoItems(name: itemName)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//
//  InsertVC.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import UIKit

class InsertUserVC: UIViewController {
    
    var username: String = ""
    var dateFormatter = DateFormatter()
    var inputDate = ""
    var db: DBHelper = DBHelper()
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveButton(_ sender: Any) {
        
    
        
        if usernameTxtField.text!.isEmpty {
            let alertController = UIAlertController(title: "Need info", message: "All fields are required", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
     
        username = usernameTxtField.text!
        dateFormatter.dateStyle = DateFormatter.Style.medium
        inputDate = dateFormatter.string(from: datePicker.date)
        db.insertIntoUser(name: username, createdAt: inputDate)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    
}

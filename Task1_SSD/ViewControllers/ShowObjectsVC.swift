//
//  ShowObjectsVC.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import UIKit
import Alamofire

class ShowObjectsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var zones: [Zone] = []
    var imageUrls: [String] = []
    var names: [String] = []
    var images: [UIImage] = []
    
    var baseUrl = "https://adsrv.sab-lab.com/api/show/app/60?uuid=fghy123sdasdasdasdasafgdfgdfa&secret=bqgqkbxgOaU3pPEt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAFRequest()
       
    }
   
    func makeAFRequest(){
        AF.request(baseUrl).validate().responseJSON { response in
            switch (response.result) {
            case .success( _):
                do {
                    
                    let innerItem = try JSONDecoder().decode(Object.self, from: response.data!)
                    
                    for item in innerItem.zone {
                        let zone = Zone(name: item.name, files: item.files)
                        
                        self.zones.append(zone)
                        //  print(self.zones)
                    }
                    
                    for zone in self.zones {
                        let imageUrl = zone.files.map{$0.url}
                        self.imageUrls.append(contentsOf: imageUrl)
                        
                        let name = zone.name
                        self.names.append(name)
                    }
                    
                    for n in 0..<10 {
                       
                        NetworkManagerAlamofire.downloadImage(url: self.imageUrls[n]) { image in
                        
                           // guard let image = image else { return }
                            self.images.append(image)
                        }
                    }
                       print(self.names)
                       print(self.imageUrls)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
            }
        }
    }
}

extension ShowObjectsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell") as! TableViewCell
        cell.nameLabel.text  = self.names[indexPath.row]
       // cell.projectsImageView.image = images[indexPath.row]
       
        // print(self.names)
        return cell
    }
}

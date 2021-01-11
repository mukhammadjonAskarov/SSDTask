//
//  NetworkManagerAlamofire.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import  Foundation
import  Alamofire

class NetworkManagerAlamofire {
        
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)-> ()){
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) {(data, response, error) in
            guard let data = data else {  return }
            let image = UIImage(data: data)!
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
        
    }
    
}


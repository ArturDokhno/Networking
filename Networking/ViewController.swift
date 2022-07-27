//
//  ViewController.swift
//  Networking
//
//  Created by Артур Дохно on 17.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getRequest(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        
    }
    
}

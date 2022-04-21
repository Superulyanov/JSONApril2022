//
//  ViewController.swift
//  JSONApril2022
//
//  Created by User on 21.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func downloadButton(_ sender: UIButton) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            URLSession.shared.dataTask(with: url) { data, response, error in
               
                if error != nil {
                    print("error in requst")
                } else {
                    print(response)
                }
           
            }
            .resume()
        }
    }
}

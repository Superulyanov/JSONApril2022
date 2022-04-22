//
//  ViewController.swift
//  JSONApril2022
//
//  Created by User on 21.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageOutlet: UIImageView!
    @IBOutlet weak var lableOutlet: UILabel!
    @IBOutlet var downloadButtonOutlet: UIButton!
    @IBOutlet var descriptionOutlet: UILabel!
    
    var imageWidth = ""
    var imageHeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let height = imageOutlet.bounds.height
        self.imageHeight = String(format:"%0.f", Double(height))
        
        let width = imageOutlet.bounds.width
        self.imageWidth = String(format: "%0.f", Double(width))
        
    }

    @IBAction func downloadButton(_ sender: UIButton) {
        
        //Этапы получения изображения с сервера:
         
        // 1) Получаем API
        let api = "https://picsum.photos/\(imageWidth)/\(imageHeight)"
        let textApi = "https://jsonplaceholder.typicode.com/posts"
        // 2) Создаем URL
        guard let url = URL(string: api) else {
            fatalError("Some error")
        }
        
        guard let textURL = URL(string: textApi) else {
            return
        }
        // 3) Инициализируем сессию
        let session = URLSession(configuration: .default)
        let textSession =  URLSession(configuration: .default)
        // 4) Создаем запрос dataTask
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.imageOutlet.image = UIImage(data: data)
            }
        }
        
        let textTask = textSession.dataTask(with: textURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
//            let jsonString = String(data: data, encoding: .utf8)
//              print(jsonString)
            do {
                let posts = try JSONDecoder().decode([PostModel].self, from: data)
                print(posts.first?.title)
                self.descriptionOutlet.text = posts.first?.title
            } catch {
                print(error)
            }
            
           
        }
        // 5) Обрабатываем полученные данные
        task.resume()
        textTask.resume()
         
        
        
        
        

        }
    }


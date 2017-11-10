//
//  ViewController.swift
//  Decoder Inc
//
//  Created by  Alecsey on 30.10.17.
//  Copyright © 2017  Alecsey. All rights reserved.
//

import UIKit

struct Post : Decodable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData { [weak self] (posts: [Post]) in
            if let s = self {
                s.posts = posts
                s.tableView.reloadData()
            }
        }
    }
}

extension ViewController {
    func getData(completion: @escaping ([Post])->()) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        URLSession.shared.dataTask(with: URL(string: url )!) { (data, response, error) in
            if error != nil {
                self.createAlert(title: "Ошибка", message: "Нет подключениек сети интернет")
                return
            }
            if (url != "https://jsonplaceholder.typicode.com/posts") {
                self.createAlert(title: "Ошибка", message: "Не удалось получить данные")
                return
            }
            guard let data = data else { return }
            let myStructArray = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                completion(myStructArray)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        let post = self.posts[indexPath.row]
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.cellLable.text = "ID: \(post.id)"
        cell.cellLableDelegate.text = "Title: \(post.title)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
        //detailsLabel.text = String("\(post.title)")
        self.createAlert(title: "Details", message: "User ID: \(post.userId) \nID: \(post.id) \nTitle: \(post.title) \nBody: \(post.body)")
    }
    // Mark : Change
//    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        let elementToMove = posts[fromIndexPath.row]
//        posts.remove(at: fromIndexPath.row)
//        posts.insert(elementToMove, at: to.row)
//    }
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    //
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


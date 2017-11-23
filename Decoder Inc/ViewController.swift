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
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add JSON Cell", message: "Введите данные ячейки:", preferredStyle: .alert)
        alert.addTextField { (jsonId) in jsonId.placeholder = "Enter ID" }
        alert.addTextField { (jsonUserId) in jsonUserId.placeholder = "Enter User ID" }
        alert.addTextField { (jsonTitle) in jsonTitle.placeholder = "Enter Title" }
        alert.addTextField { (jsonBody) in jsonBody.placeholder = "Enter Body" }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let Id = alert.textFields![0].text else { return }
            guard let UserId = alert.textFields![1].text else { return }
            guard let Title = alert.textFields![2].text else { return }
            guard let Body = alert.textFields![3].text else { return }
            if let valueId = Int(Id), let valueUser = Int(UserId) {
                self.add(Post.init(userId: valueId, id: valueUser, title: Title, body: Body))
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    func add(_ value: Post){
        let index = 0
        posts.insert(value, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
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
        performSegue(withIdentifier: "segue", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        posts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let post = self.posts[sender as! Int]
        let secondController = segue.destination as! ViewTwo
        secondController.id = "ID: \(String(post.id))"
        secondController.userId = "User ID: \(String(post.userId))"
        secondController.titlelabel = "Title: \n\(post.title)"
        secondController.body = "Body: \n\(post.body)"
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


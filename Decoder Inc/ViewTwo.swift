//
//  ViewTwo.swift
//  Decoder Inc
//
//  Created by WhoisAlecsey on 23.11.2017.
//  Copyright © 2017  Alecsey. All rights reserved.
//

import UIKit

class ViewTwo: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBAction func changeData(_ sender: Any) {
        let alert = UIAlertController(title: "Изменение ячейки", message: "Введите данные ячейки:", preferredStyle: .alert)
        alert.addTextField { (jsonId) in jsonId.text = String(self.post.id) }
        alert.addTextField { (jsonUserId) in jsonUserId.text = String(self.post.userId) }
        alert.addTextField { (jsonTitle) in jsonTitle.text = self.post.title }
        alert.addTextField { (jsonBody) in jsonBody.text = self.post.body }
        let action = UIAlertAction(title: "Change", style: .default) { (_) in
            guard let Id = alert.textFields![0].text else { return }
            guard let UserId = alert.textFields![1].text else { return }
            guard let Title = alert.textFields![2].text else { return }
            guard let Body = alert.textFields![3].text else { return }
            
            if let valueId = Int(Id), let valueUserId = Int(UserId) {
                self.post.id = valueId
                self.post.userId = valueUserId
                self.post.title = Title
                self.post.body = Body
            } else {
                self.createAlert(title: "Ошибка", message: "Данные введены не верно")
            }
            self.viewDidLoad()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    var post = Post()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = String(post.id)
        userLabel.text = String(post.userId)
        titleLabel.text = post.title
        bodyLabel.text = post.body
        
        self.tableView.reloadData()
    }
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

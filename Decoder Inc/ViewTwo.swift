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
    
    var id = String()
    var userId = String()
    var titlelabel = String()
    var body = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        idLabel.text = id
        userLabel.text = userId
        titleLabel.text = titlelabel
        bodyLabel.text = body
    }

}

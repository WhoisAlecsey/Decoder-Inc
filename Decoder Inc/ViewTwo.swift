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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

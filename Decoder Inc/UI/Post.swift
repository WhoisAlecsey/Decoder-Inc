//
//  Post.swift
//  Decoder Inc
//
//  Created by WhoisAlecsey on 14.02.2018.
//  Copyright © 2018  Alecsey. All rights reserved.
//

import Foundation

class Post : Decodable {
    init(){
        userId = 1
        id = 1
        title = "Title"
        body = "Body"
    }
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    var userId : Int
    var id : Int
    var title : String
    var body : String
}

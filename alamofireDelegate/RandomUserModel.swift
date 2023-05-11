//
//  RandomUserModel.swift
//  alamofireDelegate
//
//  Created by 홍정표 on 2023/03/26.
//

import Foundation

struct Login: Codable{
    var uuid: String
}

struct Picture: Codable{
    var large: String
    var medium: String
    var thumbnail: String
}
struct Name: Codable{
    var title: String
    var first: String
    var last: String
}

struct RandomUser: Codable{
    var name: Name
    var picture: Picture
    var login: Login
}

struct RandomUserModel: Codable{
    var results: [RandomUser]
    
}

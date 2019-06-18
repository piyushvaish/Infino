//
//  Login.swift
//  Infino
//
//  Created by Piyush Vaish on 18/06/19.
//  Copyright © 2019 Piyush Vaish. All rights reserved.
//

import Foundation

struct Login:Decodable{
    var username:String
    var password:String
}

struct LoginResponse: Decodable{
    var username:String
    var password:String
    var id:Int
}

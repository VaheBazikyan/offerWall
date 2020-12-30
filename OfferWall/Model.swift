//
//  Model.swift
//  OfferWall
//
//  Created by Ваге Базикян on 29.12.2020.
//

import Foundation

struct Product: Decodable{
    let id : Int
    let title : String
}
struct Article: Decodable {
    let type : String
    let url : String?
    let contents : String?
}



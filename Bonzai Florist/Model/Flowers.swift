//
//  Flowers.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-29.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import Foundation
import ObjectMapper

class Flowers: Mappable {
    
    var userId: Int?
    var id: Int?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    //mappable
    func mapping(map: Map) {
        
        userId  <- map["userId"]
        id      <- map["id"]
        title   <- map["title"]
    }
    
}

//
//  Photo.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-30.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import ObjectMapper

class Photo: Mappable {
    
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    required init?(map: Map) {}
    
    // Mappable
    func mapping(map: Map) {
        
        albumId         <- map["albumId"]
        id              <- map["id"]
        title           <- map["title"]
        url             <- map["url"]
        thumbnailUrl    <- map["thumbnailUrl"]
    }
}

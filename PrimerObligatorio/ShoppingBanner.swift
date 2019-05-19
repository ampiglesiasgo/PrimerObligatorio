//
//  ShoppingBanner.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import ObjectMapper
//Class of the banner
class ShoppingBanner {
    
    var bannerTittle : String?
    var bannerDescription : String?
    var bannerImageName : String?

    required init?(map: Map) {
        
    }
}

extension ShoppingBanner : Mappable {
    
    
    func mapping(map: Map) {
        bannerTittle <- map["name"]
        bannerDescription <- map["description"]
        bannerImageName <- map["photoUrl"]
    }
}


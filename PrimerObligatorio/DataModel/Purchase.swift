//
//  Purchase.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 5/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import ObjectMapper

class Purchase {
    var date: Date?
    var products : [PurchaseShoppingCartItem]?

    required init?(map: Map) {
    
    }

}

extension Purchase : Mappable {
    
    func mapping(map: Map) {
        products <- map["products"]
        date <- (map["date"], CustomDateTransform())
        }
    
}

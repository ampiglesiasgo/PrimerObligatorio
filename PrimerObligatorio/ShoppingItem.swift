//
//  ShoppingItem.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import ObjectMapper

class ShoppingItem {
//Class of the products
    var productId: Int?
    var productName : String?
    var productCategory : ProductCategory?
    var productPrice : Double?
    var productImageName : String?

    required init?(map: Map) {
        
    }
    
}

extension ShoppingItem : Mappable {
    
    func mapping(map: Map) {
        productId <- map["id"]
        productName <- map["name"]
        productPrice <- map["price"]
        productCategory <- map["category"]
        productImageName <- map["photoUrl"]
    }

}

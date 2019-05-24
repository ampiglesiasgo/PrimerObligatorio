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
    var unroundedprice: Double?

    required init?(map: Map) {
        
    }
    
}

extension ShoppingItem : Mappable {
    
    func mapping(map: Map) {
        productId <- map["id"]
        productName <- map["name"]
        unroundedprice <- map["price"]
        productPrice = Double(String(format: "%.2f", unroundedprice!))
        productCategory <- map["category"]
        productImageName <- map["photoUrl"]
    }

}

//
//  PurchaseShoppingCart.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 5/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import ObjectMapper
//Class to represente the shopping cart items.
class PurchaseShoppingCartItem {
    
    var quantity : Int?
    var product : ShoppingItem?
    var subTotal : Double { get { return product!.productPrice! * Double(quantity!) } }
    
    required init?(map: Map) {
    }
    
}


extension PurchaseShoppingCartItem : Mappable {
    
    func mapping(map: Map) {
        product <- map["products"]
        quantity <- map["quantity"]
        
    }
    
}

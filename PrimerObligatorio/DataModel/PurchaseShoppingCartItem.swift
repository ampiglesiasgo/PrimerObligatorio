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
    var subTotal : Double { get { if let product = product{if let price = product.productPrice {if let quantity = quantity{return price * Double(quantity)} else {return 0}} else {return 0}} else {return 0}}}
    
    
    required init?(map: Map) {
    }
    
}


extension PurchaseShoppingCartItem : Mappable {
    
    func mapping(map: Map) {
        product <- map["product"]
        quantity <- map["quantity"]
        
    }
    
}

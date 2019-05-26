//
//  ShoppingCartItem.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/28/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import ObjectMapper
//Class to represente the shopping cart items. 
class ShoppingCartItem {
    
    var quantity : Int = 0
    var product : ShoppingItem
    var subTotal : Double { get { return product.productPrice * Double(quantity) } }
    
    
    init(product: ShoppingItem) {
        self.product = product
    }

}

//
//  ShoppingCartItem.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/28/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class ShoppingCartItem {
    
    var quantity : Int = 1
    var product : ShoppingItem
    var subTotal : Float { get { return product.productPrice * Float(quantity) } }
    
    init(product: ShoppingItem) {
        self.product = product
    }
}

//
//  ShoppingItem.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class ShoppingItem {
    //Kiwi;Fruits;$30;kiwi.png;Kiwi-2.png
    
    var productName : String
    var productCategory : ProductCategory
    var productPrice : Double
    var productImageName : String
    var productImageCartName : String
    
    init(productName:String , productCategory : ProductCategory , productPrice:Double, productImageName:String,productImageCartName:String) {
        self.productName = productName
        self.productCategory = productCategory
        self.productPrice = productPrice
        self.productImageName = productImageName
        self.productImageCartName = productImageCartName
        
    }
    
    
    

    

}

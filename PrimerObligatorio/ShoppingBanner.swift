//
//  ShoppingBanner.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

//Kiwi;Sweet kiwi;Banner-4.png

class ShoppingBanner {
    //Kiwi;Fruits;$30;kiwi.png;Kiwi-2.png
    
    var bannerTittle : String
    var bannerDescription : String
    var bannerImageName : String

    
    init(bannerTittle:String , bannerDescription : String , bannerImageName:String) {
        self.bannerTittle = bannerTittle
        self.bannerDescription = bannerDescription
        self.bannerImageName = bannerImageName

    }
}


//
//  ModelManager.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import Kingfisher

class ModelManager {
    //Model
    private init() {}

    static let shared = ModelManager()
    
    var products: [[ShoppingItem]] = [[],[],[]]
    var banners = [ShoppingBanner]()
    var productData = [ShoppingItem]()

}

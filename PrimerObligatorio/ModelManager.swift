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


    //Set the data of the products
    func setProductData(){
//        let productsData:[[String]] = [["Kiwi","Fruits","30","kiwi.png","Kiwi-2.png"],
//                                   ["Grapefruit","Fruits","45","Grapefruit.png","Grapefruit-2.png"],
//                                   ["WaterMelon","Fruits","30","Watermelon.png","Watermelon-2.png"],
//                                   ["Avocado","Veggies","30","Avocado.png","Avocado.png"],
//                                   ["Cucumber","Veggies","30","Cucumber.png","Cucumber.png"],
//                        ["Beige","Beans","50","beaigeBean.jpg","beaigebeanShopping.jpg"],
//                        ["Black", "Beans", "40", "blackBean.png","blackBeanShopping.png"]]
        
        ApiManager.apiManager.getProducts {(shoppingItem) in
            self.productData = shoppingItem
        }
        if !productData.isEmpty{
            for i in 0...productData.count - 1 {
                switch productData[i].productCategory {
                case .fruits?:
                    if !(products[0].contains(where: { $0.productId == productData[i].productId })){
                        products[0].append(productData[i])
                    }
                case .veggies?:
                    if !(products[1].contains(where: { $0.productId == productData[i].productId })){
                        products[1].append(productData[i])
                    }
                case .dairy?:
                    if !(products[1].contains(where: { $0.productId == productData[i].productId })){
                        products[2].append(productData[i])
                    }

                default:
                    print("Dont found categories")
                }
                }
            
        }
        
    }
    
    //Set the data of the shopping banners
    func setBannerData(){
        ApiManager.apiManager.getBanners { (shoppingBanner) in
            self.banners = shoppingBanner
        }
//        let bannerData:[[String]] = [["Brazilian Banana","Product of the month","Banner-1.png"],
//                                       ["Grapefruit","Winter Fruit","Banner-2.png"],
//                                       ["Cucumber","Green Veggie","Banner-3.png"],
//                                       ["Kiwi","Sweet kiwi","Banner-4.png"]]
        
//        for i in 0...bannerData.count - 1 {
//            let shoppingBanner = ShoppingBanner(bannerTittle: bannerData[i][0],
//                                                bannerDescription : bannerData[i][1],
//                                                bannerImageName : bannerData[i][2])
//            banners.append(shoppingBanner)
//
//
//        }
        
    }
    
    
    


}

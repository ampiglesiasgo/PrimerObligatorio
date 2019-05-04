//
//  ModelManager.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class ModelManager {
    //Model
    private init() {}

    static let shared = ModelManager()
    
    var products: [[ShoppingItem]] = [[],[],[]]
    var banners = [ShoppingBanner]()

    //Set the data of the products
    func setProductData(){
        let productsData:[[String]] = [["Kiwi","Fruits","30","kiwi.png","Kiwi-2.png"],
                                   ["Grapefruit","Fruits","45","Grapefruit.png","Grapefruit-2.png"],
                                   ["WaterMelon","Fruits","30","Watermelon.png","Watermelon-2.png"],
                                   ["Avocado","Veggies","30","Avocado.png","Avocado.png"],
                                   ["Cucumber","Veggies","30","Cucumber.png","Cucumber.png"],
                        ["Beige","Beans","50","beaigeBean.jpg","beaigebeanShopping.jpg"],
                        ["Black", "Beans", "40", "blackBean.png","blackBeanShopping.png"]]
    
        
        for i in 0...productsData.count - 1 {
            let shoppingItem = ShoppingItem(productName : productsData[i][0],
                                            productCategory : ProductCategory(rawValue: productsData[i][1])!,
                                            productPrice : Double(productsData[i][2])!,
                                            productImageName : productsData[i][3],
                                            productImageCartName : productsData[i][4])
            switch shoppingItem.productCategory {
            case .Fruits:
                products[0].append(shoppingItem)
            case .Veggies:
                products[1].append(shoppingItem)
            case .Beans:
                products[2].append(shoppingItem)

            default:
                print("Dont found categories")
            }
            
        }
        
    }
    
    //Set the data of the shopping banners
    func setBannerData(){
        let bannerData:[[String]] = [["Brazilian Banana","Product of the month","Banner-1.png"],
                                       ["Grapefruit","Winter Fruit","Banner-2.png"],
                                       ["Cucumber","Green Veggie","Banner-3.png"],
                                       ["Kiwi","Sweet kiwi","Banner-4.png"]]
        
        for i in 0...bannerData.count - 1 {
            let shoppingBanner = ShoppingBanner(bannerTittle: bannerData[i][0],
                                                bannerDescription : bannerData[i][1],
                                                bannerImageName : bannerData[i][2])
            banners.append(shoppingBanner)

            
        }
    }
    
    
    


}

//
//  ApiManager.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 5/16/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiManager {
    
    private init() {}
    
    static let apiManager = ApiManager()

    let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net"

    func getProducts( completionHandler: @escaping ([ShoppingItem]) -> Void){
        let url = baseUrl + "/products"
        Alamofire.request(url).responseArray { (response: DataResponse<[ShoppingItem]>) in

            let shoppingItem = response.result.value
            completionHandler(shoppingItem!)

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \"(String(describing: response.result.error)")
                completionHandler([ShoppingItem]())
                return
            }
        }
    }
    
    func getBanners(completionHandler: @escaping ([ShoppingBanner]) -> Void){
            let url = baseUrl + "/promoted"
            Alamofire.request(url).responseArray { (response: DataResponse<[ShoppingBanner]>) in
    
                let shoppingBanner = response.result.value
                completionHandler(shoppingBanner!)
    
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \"(String(describing: response.result.error)")
                    completionHandler([ShoppingBanner]())
                    return
                }
            }
        }
    
}

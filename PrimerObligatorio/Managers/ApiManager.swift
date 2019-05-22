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
    
    
    func checkOutApi(token: String ,shoppingCartItems : [ShoppingCartItem], completionHandler: @escaping (String?) -> Void) {
        let url = baseUrl + "/checkout"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 14C07351-E2F4-49B8-AFC5-FDA310EFE792" ]

        var product: [String:Any] = [:]
        var productsList = [product]
        productsList.removeAll()
        for item in shoppingCartItems {
            product = ["product_id" : item.product.productId! , "quantity" : item.quantity ]
            productsList.append(product)
        }
        let parameters: [String: Any] = [
           "cart": productsList
        ]
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.httpBody,
                          headers: headers).responseString {
                            response in
                            switch response.result {
                            case .success:
                                print(response)
                                completionHandler("Successful purchase")
                                
                                break
                            case .failure(let error):
                                
                                print(error)
                                completionHandler("Something went wrong, try again later")
                            }
                }
    }
    
//    
//    func getPurchases( completionHandler: @escaping ([ShoppingCartItem]) -> Void){
//        let url = baseUrl + "/purchases"
//        Alamofire.request(url).responseArray { (response: DataResponse<[ShoppingCartItem]>) in
//            
//            let shoppingBanner = response.result.value
//            completionHandler(shoppingBanner!)
//            
//            guard response.result.isSuccess else {
//                print("Error while fetching remote rooms: \"(String(describing: response.result.error)")
//                completionHandler([ShoppingBanner]())
//                return
//            }
//        }
//    }
    
}

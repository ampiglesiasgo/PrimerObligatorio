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
    
    func getProducts( completionHandler: @escaping ([ShoppingItem]?,Error?) -> Void){
        let url = baseUrl + "/products"
        Alamofire.request(url,method: .get).responseArray { (response: DataResponse<[ShoppingItem]>) in

            guard response.result.isSuccess else {
                completionHandler(nil,response.result.error)
                return
            }
            let shoppingItem = response.result.value
            completionHandler(shoppingItem,nil)

        }
    }
    
    func getBanners(completionHandler: @escaping ([ShoppingBanner]?,Error?) -> Void){
            let url = baseUrl + "/promoted"
            Alamofire.request(url,method: .get).responseArray { (response: DataResponse<[ShoppingBanner]>) in
        
                guard response.result.isSuccess else {
                    print("Error \(String(describing: response.result.error))")
                    completionHandler(nil,response.result.error)
                    return
                }
                let shoppingBanner = response.result.value
                completionHandler(shoppingBanner,nil)

            }
        }
    
    
    func checkOutApi(token: String ,shoppingCartItems : [ShoppingCartItem], completionHandler: @escaping (String?,Error?) -> Void) {
        let url = baseUrl + "/checkout"
        let headers: HTTPHeaders = [
            "Authorization": token ,
            "content-type":"application/json"]

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
                          encoding: JSONEncoding.default,
                          headers: headers).responseString {
                            response in
                            switch response.result {
                            case .success:
                                completionHandler(response.description,nil)
                                
                                break
                            case .failure(let error):
                                completionHandler(nil,error)
                            }
                }
    }
    
    func getPurchases(token: String, completionHandler: @escaping ([Purchase]?,Error?) -> Void){
        let url = baseUrl + "/purchases"
        let headers: HTTPHeaders = [
            "Authorization": token ]
        Alamofire.request(url,headers: headers).responseArray { (response: DataResponse<[Purchase]>) in
            
            let purchase = response.result.value
            if let purchase = purchase{
                completionHandler(purchase,nil)
            }
            
            guard response.result.isSuccess else {
                print("Error: \"(String(describing: response.result.error)")
                completionHandler(nil,response.result.error)
                return
            }
        }
    }
    
}

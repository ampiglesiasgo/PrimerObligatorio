//
//  ShoppingCartViewController.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/28/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ShoppingCartCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var priceTotalOutlet: UILabel!
    @IBOutlet weak var checkOutButtonOutlet: UIButton!
    @IBOutlet weak var shoppingCartLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var shopingCartList = [ShoppingCartItem]()
    var purchaseList = [PurchaseShoppingCartItem]()
    let pickerData = ["1","2","3","4","5","6","7","8","9","10"]
    var quantitySelected = ""
    var mainViewController:ViewController?
    var fromPurcharseList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkOutButtonOutlet.frame.size.height = 50
        checkOutButtonOutlet.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if shopingCartList.count == 0 || fromPurcharseList {
            checkOutButtonOutlet.isHidden = true

        }
        if fromPurcharseList{
            ShoppingCartCollectionViewOutlet.reloadData()
            shoppingCartLabel.text = "Purchase History"
        }
        else {
            shoppingCartLabel.text = "Shopping Cart"
        }
        activityIndicator.isHidden = true
        total()
    }
    
    //Code to administrate the collection of products in the shopping cart
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fromPurcharseList{
            return purchaseList.count
        }
        return shopingCartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCartCollectionCell", for: indexPath) as! ShoppingCartCollectionViewCell
        if fromPurcharseList{
            let purchaseShoppingItem = purchaseList[indexPath.row]
            if let product = purchaseShoppingItem.product {
                if let productImageName = product.productImageName{
                    cell.shoppingCartImageOutlet.kf.setImage(with: URL(string: productImageName))
                }
                else{
                    cell.shoppingCartImageOutlet.image = UIImage(named:"No_image")
                }
                if let productName = product.productName{
                    cell.shoppingCartNameItemOutlet.text = productName
                }
                else {
                    cell.shoppingCartNameItemOutlet.text = "Product Name not available"
                }
                cell.shoppingCartPriceItemOutlet.text = "$" + String(describing: product.productPrice)
                if let productQuantity = purchaseShoppingItem.quantity{
                    cell.shoppingCartCantItemOutlet.text = String(describing: productQuantity) + " units"
                }
                else {cell.shoppingCartCantItemOutlet.text = "No product units available"}
            }
        }
        else {
                var shoppingItem: ShoppingCartItem

                shoppingItem = shopingCartList[indexPath.row]
            
            if let productImageName = shoppingItem.product.productImageName{
                cell.shoppingCartImageOutlet.kf.setImage(with: URL(string: productImageName))
            }
            else{
                cell.shoppingCartImageOutlet.image = UIImage(named:"No_image")
            }
            if let productName = shoppingItem.product.productName{
                cell.shoppingCartNameItemOutlet.text = productName
            }
            else {cell.shoppingCartNameItemOutlet.text = "Product Name not available"}
            cell.shoppingCartPriceItemOutlet.text = "$" + String(describing: shoppingItem.product.productPrice)
            cell.shoppingCartCantItemOutlet.text = String(shoppingItem.quantity) + " units"
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
    
    //Function of the checkOut button
    @IBAction func checkOutButtonAction(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        AuthenticationManager.shared.authenticate(onCompletion: {response in
            let token = "Bearer \(response.token)"
            ApiManager.apiManager.checkOutApi(token: token, shoppingCartItems: self.shopingCartList) { (message,error) in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                if let msgPurchase = message{
                    let checkOutInMsg = UIAlertController(title: "CheckOut", message: msgPurchase, preferredStyle: .alert)
                    let okAcction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
                        UIAlertAction in
                        self.shopingCartList = [ShoppingCartItem]()
                        self.mainViewController?.shoppingcart = self.shopingCartList
                        self.mainViewController?.tableViewOutlet.reloadData()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    checkOutInMsg.addAction(okAcction)
                    self.present(checkOutInMsg, animated: true, completion: nil)
                }
                else {
                    let msgError = error?.localizedDescription
                    let Error = UIAlertController(title: "Error", message: msgError, preferredStyle: .alert)
                    let okAcction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    Error.addAction(okAcction)
                    self.present(Error, animated: true, completion: nil)
                }
            }
        })
    }
    
    func total(){
        var total = 0.0
        if fromPurcharseList {
            for item in purchaseList{
                total += item.subTotal
            }
        }
        else {
            for item in shopingCartList{
                total += item.subTotal
            }
            }
        priceTotalOutlet.text = "$" + String(total)

        }
}

//Code to administrate the pickerview to change quantity of the products in the shopping cart

extension ShoppingCartViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantitySelected = pickerData[row]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(fromPurcharseList){
            let alertView = UIAlertController(
                title: "Select quantity",
                message: "\n\n\n\n\n\n\n\n\n",
                preferredStyle: .alert)
            
            let pickerView = UIPickerView(frame:
                CGRect(x: 0, y: 50, width: 260, height: 162))
            pickerView.dataSource = self
            pickerView.delegate = self
            alertView.view.addSubview(pickerView)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                UIAlertAction in
                let shopItem = self.shopingCartList[indexPath.row]
                if self.quantitySelected != "" {
                    shopItem.quantity = Int(self.quantitySelected)!
                }
                self.ShoppingCartCollectionViewOutlet.reloadItems(at: [indexPath])
                self.total()
            }
            alertView.addAction(action)
            present(alertView, animated: true, completion: { pickerView.frame.size.width = alertView.view.frame.size.width})
        }
    }

}

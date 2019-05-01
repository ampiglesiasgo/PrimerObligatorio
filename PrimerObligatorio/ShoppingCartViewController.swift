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
    
    var shopingCartList = [ShoppingCartItem]()
    let pickerData = ["1","2","3","4","5","6","7","8","9","10"]
    var quantitySelected = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shopingCartList = ModelManager.shared.products
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkOutButtonOutlet.frame.size.height = 50
        checkOutButtonOutlet.layer.cornerRadius = 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        total()
        if shopingCartList.count == 0 {
            checkOutButtonOutlet.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopingCartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCartCollectionCell", for: indexPath) as! ShoppingCartCollectionViewCell
    
        let shoppingItem = shopingCartList[indexPath.row]
        print("shoppingItem " + "\(shoppingItem)")

        cell.shoppingCartImageOutlet.image = UIImage(named: shoppingItem.product.productImageCartName)
        cell.shoppingCartNameItemOutlet.text = shoppingItem.product.productName
        cell.shoppingCartPriceItemOutlet.text = "$" + String(shoppingItem.product.productPrice)
        cell.shoppingCartCantItemOutlet.text = String(shoppingItem.quantity) + " units"
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
    
    @IBAction func checkOutButtonAction(_ sender: Any) {
        let checkOutInMsg = UIAlertController(title: "CheckOut", message: "Successful purchase", preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            UIAlertAction in
            self.shopingCartList = [ShoppingCartItem]()
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        checkOutInMsg.addAction(okAcction)
        self.present(checkOutInMsg, animated: true, completion: nil)


    }
    
    
    func total(){
        var total = 0.0
        for item in shopingCartList{
            total += item.subTotal
        }
        priceTotalOutlet.text = "$" + String(total)
        
    }

}


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
            shopItem.quantity = Int(self.quantitySelected)!
            self.ShoppingCartCollectionViewOutlet.reloadItems(at: [indexPath])
            self.total()
        }
        alertView.addAction(action)
        present(alertView, animated: true, completion: { pickerView.frame.size.width = alertView.view.frame.size.width})
    }

}

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
        _ = navigationController?.popToRootViewController(animated: true)

    }
    
    
    
}

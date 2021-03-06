//
//  PurchaseHistoryViewController.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 5/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var purchaseTableViewOutlet: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noPurchaseHistorylabel: UILabel!
    
    var purchaseList = [Purchase]()
    var purchaseItem = [PurchaseShoppingCartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        purchaseTableViewOutlet.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noPurchaseHistorylabel.isHidden = true
        activityIndicator.startAnimating()
        AuthenticationManager.shared.authenticate { (response) in
            let token = "Bearer \(response.token)"
            ApiManager.apiManager.getPurchases(token: token) { (purchase,error) in
                self.purchaseTableViewOutlet.isHidden = false
                self.activityIndicator.stopAnimating()
                if let purchase = purchase {
                    self.purchaseList = purchase
                    self.purchaseTableViewOutlet.reloadData()
                    if self.purchaseList.isEmpty{
                        self.noPurchaseHistorylabel.isHidden = false
                        self.noPurchaseHistorylabel.text = "You don't have a purchase history"
                    }
                }
                else {
                    let msgError = error?.localizedDescription
                    let Error = UIAlertController(title: "Error", message: msgError, preferredStyle: .alert)
                    let okAcction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    Error.addAction(okAcction)
                    self.present(Error, animated: true, completion: nil)
                }
            }
            self.activityIndicator.isHidden = true

        }

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseHistoryCell", for : indexPath) as! PurchaseHistoryTableViewCell

        let item = purchaseList[indexPath.row]
        var total:Double = 0.0
        for product in item.products!{
            if product.quantity != nil{
                total = total + product.subTotal
            }
        }
        
        if let date = item.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            cell.datePurchaseLabelOutlet.text = "\(dateFormatter.string(from: date))"
        }
        cell.pricePurchaseLabelOutlet.text = "Price: $\(total)"
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

extension PurchaseHistoryViewController: PurchaseHistoryTableViewCellDelegate {
    
    
    //Send data to the shoppingCartViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "purcheseHistoryViewControllerSegue"{
            let shoppingCartViewController = (segue.destination as! ShoppingCartViewController)
            shoppingCartViewController.purchaseList =  purchaseItem
            shoppingCartViewController.fromPurcharseList = true
        }
    }
    
    func showDetails(cell: PurchaseHistoryTableViewCell) {
        guard let indexPath = purchaseTableViewOutlet.indexPath(for: cell) else { return }
        if let products = purchaseList[indexPath.row].products {
            purchaseItem = products
        }
        performSegue(withIdentifier: "purcheseHistoryViewControllerSegue", sender: self)

    }
    
    
    
    
}

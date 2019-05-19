//
//  ViewController.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/23/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var pageControlOutlet: UIPageControl!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    
    private var currentPage: Int = 0
    var widthCell:CGFloat = 0
    var categories = [ProductCategory]()
    var filteredTableData: [[ShoppingItem]] = [[],[],[]]
    var searching = false
    var shoppingcart = [ShoppingCartItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial Data
        ModelManager.shared.setProductData()
        ModelManager.shared.setBannerData()
        pageControlOutlet.numberOfPages = ModelManager.shared.banners.count
        for product in ModelManager.shared.products{
            if !(product.isEmpty){
                for i in 0...product.count - 1 {
                    if !(categories.contains(product[i].productCategory!)){
                        categories.append(product[i].productCategory!)
                    }
                }
            }
        }
        let imageBack = UIImage(named: "icon-back.png")
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ModelManager.shared.setBannerData()
        collectionViewOutlet.reloadData()
        pageControlOutlet.numberOfPages = ModelManager.shared.banners.count
        ModelManager.shared.setProductData()
        print(ModelManager.shared.products)
        for product in ModelManager.shared.products{
            if !(product.isEmpty){
            for i in 0...product.count - 1 {
                if !(categories.contains(product[i].productCategory!)){
                    categories.append(product[i].productCategory!)
                }
            }
            }
        }
        tableViewOutlet.reloadData()

    }
    
    
    //Code to administrate the tableview of products
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return filteredTableData[section].count
        }
        return ModelManager.shared.products[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! TableViewCell
        var item : ShoppingItem
        if searching {
            item = filteredTableData[indexPath.section][indexPath.row]
        }
        else{
            item = ModelManager.shared.products[indexPath.section][indexPath.row]
        }
        
        var itemInCar = false

        for shoppingCartItem in shoppingcart {
            if shoppingCartItem.product.productName == item.productName {
                itemInCar = true
                let buttonPlusViewOutletIsHidden = shoppingCartItem.quantity == 0
                cell.buttonPlusViewOutlet.isHidden = buttonPlusViewOutletIsHidden
                cell.addButtonOutlet.isHidden = !buttonPlusViewOutletIsHidden
                cell.buttonCountOutlet.text = String(shoppingCartItem.quantity)
            }
            
        }
        if !itemInCar{
            cell.addButtonOutlet.isHidden = false
            cell.buttonPlusViewOutlet.isHidden = true
        }
        cell.nameLabelOutlet.text = item.productName
        cell.priceLabelOutlet.text = "$" + String(describing: item.productPrice)
        if let productImageName = item.productImageName{
            cell.productImageOutlet.kf.setImage(with: URL(string: productImageName))
        }
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.categories[section]
        return section.rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    //Send data to the shoppingCartViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "shoppingCartViewControllerSegue"{
                let shoppingCartViewController = (segue.destination as! ShoppingCartViewController)
                    shoppingCartViewController.shopingCartList = shoppingcart
                    shoppingCartViewController.mainViewController = self
            }
    }


    @IBAction func shoppingCartButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "shoppingCartViewControllerSegue", sender: self)

    }

}

// Code to create and configurate the banner
extension ViewController :UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return ModelManager.shared.banners.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            
            let banner = ModelManager.shared.banners[indexPath.row]
            cell.imageBannerViewOutlet.kf.setImage(with: URL(string: banner.bannerImageName!))
            cell.tittleLabelOutlet.text = banner.bannerTittle
            cell.descriptionLabelOutlet.text = banner.bannerDescription
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControlOutlet.currentPage = indexPath.row
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewOutlet.frame.size.width - 8 , height: collectionViewOutlet.frame.size.height)
    }

}

//Code to administrate the search view of the table
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTableData = [[],[],[]]
        var auxArray = [String]()
        var searchItems = [String]()
        for i in 0...ModelManager.shared.products.count - 1 {
            for shopitm in ModelManager.shared.products[i]{
                auxArray.append(shopitm.productName!)
            }
        }
        searchItems = auxArray.filter({$0.prefix(searchText.count) == searchText})
        for i in 0...ModelManager.shared.products.count - 1  {
            for txt in searchItems{
                for shopIt in ModelManager.shared.products[i]{
                    if shopIt.productName == txt{
                        switch shopIt.productCategory {
                        case .fruits?:
                            filteredTableData[0].append(shopIt)
                        case .veggies?:
                            filteredTableData[1].append(shopIt)
                        case .dairy?:
                            filteredTableData[2].append(shopIt)

                        default:
                            print("No categories detected")
                        }
                    }
                    
                }
            }
            searching = true

        }
        tableViewOutlet.reloadData()

    }
}
//Define the function of the TableViewCellDelegate delegate.
extension ViewController: TableViewCellDelegate {
    
    // MARK: - CartDelegate
    func updateCart(cell: TableViewCell,buttonCall: String) {
        guard let indexPath = tableViewOutlet.indexPath(for: cell) else { return }
        let product = ModelManager.shared.products[indexPath.section][indexPath.row]
        if buttonCall == "add"{
            let shoppingCartItem = ShoppingCartItem(product: product)
            shoppingCartItem.quantity += 1
            shoppingcart.append(shoppingCartItem)
        }
        if buttonCall == "plus"{
            let product = ModelManager.shared.products[indexPath.section][indexPath.row]
            let i = shoppingcart.index(where: { $0.product.productName == product.productName })
            let item = shoppingcart[i!]
            item.quantity = item.quantity + 1
            cell.buttonCountOutlet.text = String(item.quantity)
        }
        if buttonCall == "minus"{
            let product = ModelManager.shared.products[indexPath.section][indexPath.row]
            let i = shoppingcart.index(where: { $0.product.productName == product.productName })
            let item = shoppingcart[i!]
            item.quantity = item.quantity - 1
            if item.quantity == 0 {
                shoppingcart.remove(at: i!)
            }
            cell.buttonCountOutlet.text = String(item.quantity)
        }
    }
    
    func didTapAdd(_ sender: TableViewCell) {
        sender.addButtonOutlet.isHidden = true
        sender.buttonPlusViewOutlet.isHidden = false
        sender.buttonCountOutlet.text = "1"

    }
    
    func didTapPlusMinus(_ sender: TableViewCell) {
       if sender.buttonCountOutlet.text == "0"{
           sender.addButtonOutlet.isHidden = false
           sender.buttonPlusViewOutlet.isHidden = true


       }
    }
    
}


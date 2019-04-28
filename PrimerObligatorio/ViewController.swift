//
//  ViewController.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/23/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    private var currentPage: Int = 0
    var widthCell:CGFloat = 0
    var categories = [ProductCategory]()

    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var pageControlOutlet: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelManager.shared.setProductData()
        ModelManager.shared.setBannerData()
        pageControlOutlet.numberOfPages = ModelManager.shared.banners.count
        
        for product in ModelManager.shared.products{
            print("PRODUCT " + "\(product.productCategory)")
            if !(categories.contains(product.productCategory)){
                categories.append(product.productCategory)
            }
            
        }
        print("cantidad de categorias " + "\(categories.count)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! TableViewCell
        
        
        let item = ModelManager.shared.products[indexPath.row]
        //print("item " + "\(indexPath.row)")

        //cell.textLabel?.text = item
        cell.nameLabelOutlet.text = item.productName
        cell.priceLabelOutlet.text = item.productPrice
        cell.productImageOutlet.image = UIImage(named: item.productImageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.categories[section]
        //print("section " + "\(section.rawValue)")
        return section.rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
}
    
extension ViewController :UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return ModelManager.shared.banners.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            
            let banner = ModelManager.shared.banners[indexPath.row]
            //print("Banner " + "\(indexPath.row)")

            cell.imageBannerViewOutlet.image = UIImage(named: banner.bannerImageName)
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


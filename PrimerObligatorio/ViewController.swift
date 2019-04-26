//
//  ViewController.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/23/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    //var products:[[String]] = [[],[],[],[],[]]
    var products:[[String]] = [["Kiwi","Grapefruit","WaterMelon"],["Avocado","Cucumber"]]
    var product:String = ""
    var categories = [ "Fruits", "Veggies"]
    var imageName:[[String]] = [["kiwi.png","Grapefruit.png","Watermelon.png"],["Avocado.png","Cucumber.png"]]
    var prices: [[String]] = [["$30","$45","$30"],["$30","$30"]]
    var imageBanner:[String] = ["Banner-1.png","Banner-2.png","Banner-3.png","Banner-4.png"]
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var pageControlOutlet: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlOutlet.numberOfPages = imageBanner.count

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! TableViewCell
        let item = products[indexPath.section][indexPath.row]
        //cell.textLabel?.text = item
        cell.nameLabelOutlet.text = item
        cell.priceLabelOutlet.text = prices[indexPath.section][indexPath.row]
        cell.productImageOutlet.image = UIImage(named: imageName[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        if tableViewOutlet.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
//        {
//            tableViewOutlet.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
//        }
//        else
//        {
//            tableViewOutlet.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == UITableViewCellEditingStyle.delete
//        {
//            products.remove(at: indexPath.row)
//            tableViewOutlet.reloadData()
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.categories[section]
        return section
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
}
    
extension ViewController :UICollectionViewDataSource , UICollectionViewDelegate {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageBanner.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            
            //cell.cellLabelOutlet.text = categories[indexPath.item]
            //cell.celllabelOutlet.adjustsFontSizeToFitWidth = true
            cell.imageBannerViewOutlet.image = UIImage(named: imageBanner[indexPath.row])
            cell.tittleLabelOutlet.text = "Brazilian Banana"
            cell.descriptionLabelOutlet.text = "Product of the month"
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            collectionViewOutlet.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            return cell
            
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControlOutlet.currentPage = indexPath.row
    }
    





}


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
    
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print("index path " + "\(indexPath.row)")
        print("Item " + "\(item)")
        let radius = cell.productImageOutlet.frame.width / 2
        cell.productImageOutlet.layer.cornerRadius = radius
        cell.productImageOutlet.layer.masksToBounds = true
        cell.nameLabelOutlet.text = item
        cell.priceLabelOutlet.text = prices[indexPath.section][indexPath.row]
        cell.productImageOutlet.image = UIImage(named: imageName[indexPath.section][indexPath.row])
        
        
        return cell
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
    
    


}


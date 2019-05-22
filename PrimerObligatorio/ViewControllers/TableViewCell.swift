//
//  TableViewCell.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/24/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    func updateCart(cell: TableViewCell,buttonCall: String)
    func didTapAdd(_ sender: TableViewCell)
    func didTapPlusMinus(_ sender: TableViewCell)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var productImageOutlet: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var priceLabelOutlet: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var buttonPlusViewOutlet: UIView!
    @IBOutlet weak var buttonPlusOutlet: UIButton!
    @IBOutlet weak var buttonCountOutlet: UILabel!
    @IBOutlet weak var buttonMinusOutlet: UIButton!
    
    var delegate : TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // Apply changes in the product image and the buttons
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = productImageOutlet.frame.width / 2
        productImageOutlet.layer.cornerRadius = radius
        productImageOutlet.layer.masksToBounds = true
        addButtonOutlet.layer.cornerRadius = 15
        addButtonOutlet.clipsToBounds = true
        addButtonOutlet.backgroundColor = .clear
        addButtonOutlet.layer.borderWidth = 2
        addButtonOutlet.layer.borderColor = UIColor.blue.cgColor
        buttonPlusViewOutlet.layer.borderWidth=1
        buttonPlusViewOutlet.layer.cornerRadius = 15
        buttonPlusViewOutlet.layer.borderColor = UIColor.lightGray.cgColor
    }

    //Methods of the buttons cells 
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "add")
        self.delegate?.didTapAdd(self)
        
    }
    
    @IBAction func plusButoonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "plus")
        self.delegate?.didTapPlusMinus(self)


    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "minus")
        self.delegate?.didTapPlusMinus(self)

    }
}

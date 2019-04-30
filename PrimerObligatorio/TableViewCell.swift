//
//  TableViewCell.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/24/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

protocol ShoppingCartDelegate {
    func updateCart(cell: TableViewCell,buttonCall: String)
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
    
    var delegate : ShoppingCartDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonPlusViewOutlet.isHidden = true

    }
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "add")
    }
    
    @IBAction func plusButoonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "plus")

    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        self.delegate?.updateCart(cell: self, buttonCall: "minus")

    }
}

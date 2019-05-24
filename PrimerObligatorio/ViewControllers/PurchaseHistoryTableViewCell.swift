//
//  PurchaseHistoryTableViewCell.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 5/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

protocol PurchaseHistoryTableViewCellDelegate {
    func showDetails(cell: PurchaseHistoryTableViewCell)
}


class PurchaseHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var datePurchaseLabelOutlet: UILabel!
    @IBOutlet weak var detailsPurchaseButtonOutlet: UIButton!
    @IBOutlet weak var pricePurchaseLabelOutlet: UILabel!
    
    var delegate : PurchaseHistoryTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detailsPurchaseButtonOutlet.layer.cornerRadius = 15
        detailsPurchaseButtonOutlet.clipsToBounds = true
        detailsPurchaseButtonOutlet.backgroundColor = .clear
        detailsPurchaseButtonOutlet.layer.borderWidth = 1
        detailsPurchaseButtonOutlet.layer.borderColor = UIColor.blue.cgColor

    }
    
    
    @IBAction func detailsPurcheseButtonAction(_ sender: Any) {
        self.delegate?.showDetails(cell: self)
    }
    


    
}

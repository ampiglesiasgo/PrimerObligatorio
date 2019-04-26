//
//  TableViewCell.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/24/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var productImageOutlet: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var priceLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = productImageOutlet.frame.width / 2
        productImageOutlet.layer.cornerRadius = radius
        productImageOutlet.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}

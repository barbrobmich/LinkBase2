//
//  LanguageItemCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/22/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LanguageItemCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: PFImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemUrlLabel: UILabel!
    @IBOutlet weak var itemDatesLabel: UILabel!
    @IBOutlet weak var itemRoleLabel: UILabel!
    
    var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        itemImageView.layer.cornerRadius = 3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

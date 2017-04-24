//
//  CompanyCollectionCell.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class CompanyCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var compImg: UIImageView!
    @IBOutlet weak var compNamLb: UILabel!
    
    var company: Company!{
        didSet{
            self.compNamLb.text = company.name!
            self.compImg.image = company.logo!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.compImg.contentMode = UIViewContentMode.scaleAspectFit
        self.compImg.clipsToBounds = true
    }
    
}

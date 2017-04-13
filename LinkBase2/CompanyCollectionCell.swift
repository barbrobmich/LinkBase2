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
        }
    }
    
    

    @IBAction func favorite(_ sender: Any) {
        
    }
    
    
}

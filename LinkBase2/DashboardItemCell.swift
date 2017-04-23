//
//  DashboardItemCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class DashboardItemCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var languageImageView: UIImageView! {
        didSet{
            languageImageView.layer.cornerRadius = 3 
        }
    }
    
    @IBOutlet weak var languageNameLabel: UILabel!
    
    @IBOutlet weak var itemsCountLabel: UILabel!

    @IBOutlet weak var categoriesLabel: UILabel!
}

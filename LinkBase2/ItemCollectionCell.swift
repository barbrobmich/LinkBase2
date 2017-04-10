//
//  ItemCollectionCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ItemCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var addItemButton: UIButton!
    
    @IBOutlet weak var itemImageView: UIImageView! {
        
        didSet{
            itemImageView.layer.cornerRadius = 3
        }
        
    }
    
    @IBOutlet weak var itemNameLabel: UILabel! {
        
        didSet{
            
            itemNameLabel.layer.borderWidth = 1
            itemNameLabel.layer.borderColor = UIColor.white.cgColor
            itemNameLabel.layer.cornerRadius = 3
        }
    }
    
    var selectItemDelegate: DidSelectItem? {
        didSet{
            
        }
    }
    
    @IBAction func didSelectAddItem(_ sender: UIButton) {
        let tag = addItemButton.tag
        print("did press add button at index \(tag)")
        self.selectItemDelegate?.didSelectCategory(tag: tag)

    }
}


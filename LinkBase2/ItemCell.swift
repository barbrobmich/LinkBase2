//
//  ItemCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!

    var cellSection: Int!
    var items: [Item] = []
    var categories = [Item.category.Education, Item.category.Professional, Item.category.Community, Item.category.Other]
    var selectItemDelegate: DidSelectItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionView.dataSource = self
        collectionView.delegate = self 
        // Configure the view for the selected state
    }

    
    
    
}

extension ItemCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellSection == 1 {
            return items.count
        }
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionCell", for: indexPath) as! ItemCollectionCell
        
        if cellSection == 1 {
            cell.itemNameLabel.text = items[indexPath.item].name
        }
            
        else if cellSection == 2 {
            cell.itemNameLabel.text = String(describing: categories[indexPath.item])
            addBlurToImage(image: cell.itemImageView, type: .dark)
            cell.addItemButton.tag = indexPath.item
            cell.selectItemDelegate = selectItemDelegate
        }
        
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        if cellSection == 1 {
//            
//            let selectedIndex = items[indexPath.item].name!
//            print("Selected Index: \(selectedIndex)")
//            
//        } else if cellSection == 2 {
//            let selectedIndex = categories[indexPath.item]
//            print("Selected Index: \(selectedIndex)")
//        }
//    }
}


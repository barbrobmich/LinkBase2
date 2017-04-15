//
//  ItemCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!

    var cellSection: Int!
    var items: [Item] = []
    var categories = [Item.category.Education, Item.category.Professional, Item.category.Community, Item.category.Other]
    var selectItemDelegate: DidSelectItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fetchItems()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionView.dataSource = self
        collectionView.delegate = self 
        // Configure the view for the selected state
    }
    
    func fetchItems() {

        let query = PFQuery(className: Item.parseClassName())
        
        query.order(byDescending: "_created_at")
        query.whereKey("user", equalTo: PFUser.current()?.username!)
        query.limit = 20
        query.findObjectsInBackground { (parseItems: [PFObject]?, error: Error?) -> Void in
            
            if let myItems = parseItems {
                print("ParseItems: \(parseItems!)")
                for item in myItems {
                    if item is Item {
                        print("object is subclass")
                    }
                    if let item = item as? Item {
                        print("object cast as item")
                        self.items.insert(item, at: 0)
                    }
                }
                self.collectionView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }

}

extension ItemCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellSection == 1 {
            print("ItemsCount is \(items.count)")
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

extension ItemCell {
    


}



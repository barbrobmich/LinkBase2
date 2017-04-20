//
//  Item.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/9/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

import Foundation
import Parse

class Item: PFObject, PFSubclassing {
    
    enum category {
        case Education, Professional, Community, Other
    }
    
    static func parseClassName() -> String {
        return "Item"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var itemImageFile: PFFile?
    @NSManaged var itemImage: UIImage
    @NSManaged var role: String?
    @NSManaged var url: String?
    @NSManaged var fromMonth: Int
    @NSManaged var fromYear: Int
    @NSManaged var toMonth: Int
    @NSManaged var toYear: Int
    
    
    init(user: PFUser, name: String?) {
        super.init()
        
        self.user = user
        self.name = name
    }
    
    override init() {
        super.init()
    }
    
    class func postItemToParse(item: Item, withCompletion completion: PFBooleanResultBlock?) {
        
        let Item = PFObject(className: "Item")
        Item["name"] = item.name
        Item["role"] = item.role
        Item["url"] = item.url
        Item["item_imageFile"] = item.itemImageFile
        let user = PFUser.current()
        Item["user"] = user?.username
        Item["from_month"] = item.fromMonth
        Item["from_year"] = item.fromYear
        Item["to_month"] = item.toMonth
        Item["to_year"] = item.toYear
        Item.saveInBackground(block: completion)
        
    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

    
}

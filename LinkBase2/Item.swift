//
//  Item.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import Foundation
import Parse

class Item: PFObject {
    
    enum category {
        case Education, Professional, Community, Other
    }
    
    static func parseClassName() -> String {
        return "Affiliation"
    }
    
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var itemImage: PFFile?
    
    init(user: PFUser, name: String?) {
        super.init()
        
        self.user = user
        self.name = name
    }
    
    override init() {
        super.init()
    }

}

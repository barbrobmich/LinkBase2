//
//  Language.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/22/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import Foundation
import UIKit

class Language {
 
    var languages: [String] = ["C++", "Go", "Haskell", "Java", "Javascript", "Objective C", "Prolog", "Python", "R", "Ruby", "SQL", "Swift"]
    
    var langImages: [UIImage] = [(#imageLiteral(resourceName: "cpp")), (#imageLiteral(resourceName: "go")), (#imageLiteral(resourceName: "haskell")), (#imageLiteral(resourceName: "java")), (#imageLiteral(resourceName: "javascript")), (#imageLiteral(resourceName: "objectiveC")), (#imageLiteral(resourceName: "prolog")), (#imageLiteral(resourceName: "python")), (#imageLiteral(resourceName: "R")), (#imageLiteral(resourceName: "ruby")), (#imageLiteral(resourceName: "sql")), (#imageLiteral(resourceName: "swift"))]
    
    var langInt: Int? 
    var items: [Item]?
    var langName: String?
    var langImage: UIImage?
    var langCategories: Set<String>?
    init(index: Int) {
        
        langInt = index
        langName = languages[index]
        langImage = langImages[index]
        items = []
        langCategories = []
    }
    
    
}

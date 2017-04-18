//
//  Company.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

enum CompClassification: String{
    case seriesA = "Series A"
    case seriesB = "Series B"
    case seriesC = "Series C"
    case seriesG = "Series G"
    case Public = "Public"
}

class Company: NSObject {
	var name: String?
	var logo: UIImage?
	var questions: [Question] = []
    var numEmployees: Int = 0
    var numOfAcquisitions: Int = 0
    var isPublic: Bool = false
    var wentPublic: String?
    var founders: [String]?
    var compDescription: String?
    var classifications: CompClassification
    var compUrl: URL?
    //var address: Address Todo, make Address Model
    //var event: Event Todo, make Event Model
	
	init(name: String, logo: UIImage, questions: [Question]) {
		self.name = name
		self.logo = logo
		self.questions = questions
        self.classifications = .Public
	}
    
    init(name: String, numEmployees: Int, logo: UIImage, classification: CompClassification = .Public, isPub: Bool){
        self.name = name
        self.numEmployees = numEmployees
        self.logo = logo
        self.classifications = classification
        self.isPublic = isPub
        
    }
    
    init(hash: [String:Any]){
        
        self.name = hash["name"] as! String?
        self.logo = hash["logo"] as! UIImage?
        self.questions = hash["question"] as! [Question]
        self.numEmployees = hash["numEmploy"] as! Int
        self.numOfAcquisitions = hash["numAcq"] as! Int
        self.wentPublic = hash["wentPub"] as! String?
        self.isPublic = hash["isPub"] as! Bool
        self.founders = hash["founder"] as! [String]?
        self.compDescription = hash["desc"] as! String?
        self.classifications = CompClassification(rawValue: hash["class"] as! String)!
        self.compUrl = URL(string: hash["url"] as! String)
    }
    
    init(object: PFObject){
        name =              object["name"] as? String
        numEmployees =      object["numEmployees"] as! Int
        numOfAcquisitions = object["numAcqs"] as! Int
        isPublic =          object["isPublic"] as! Bool
        wentPublic =        object["wentPublic"] as? String
        //        founders =          object["founders"] as? [String]
        compDescription =   object["description"] as? String
        //        classifications =   object["classif"] as? [String]?
        //        compUrl =           object["url"] as? URL
        self.classifications = CompClassification(rawValue: (object["classification"] as? String)!)!
        
    }
    
    class func postCompany(withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Company")
        
        // Add relevant fields to the object
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
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

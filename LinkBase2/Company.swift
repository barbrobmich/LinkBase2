//
//  Company.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

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
    var classifications: [String]?
    var compUrl: URL?
    //var address: Address Todo, make Address Model
    //var event: Event Todo, make Event Model
	
	init(name: String, logo: UIImage, questions: [Question]) {
		self.name = name
		self.logo = logo
		self.questions = questions
	}
    
    init(name: String, numEmployees: Int){
        self.name = name
        self.numEmployees = numEmployees
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

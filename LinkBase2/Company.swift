//
//  Company.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class Company: NSObject {
	var name: String?
	var image: UIImage?
	var questions: [Question] = []
	
	init(name: String, image: UIImage, questions: [Question]) {
		self.name = name
		self.image = image
		self.questions = questions
	}
}

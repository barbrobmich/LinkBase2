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
	var logo: UIImage?
	var questions: [Question] = []
	
	init(name: String, logo: UIImage, questions: [Question]) {
		self.name = name
		self.logo = logo
		self.questions = questions
	}
}

//
//  Question.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class Question: NSObject {
	var question: String?
	var choices: [String]?
	var correctAnswerIndex: Int?
	
	init(question: String, choices: [String], correctAnswerIndex: Int) {
		self.question = question
		self.choices = choices
		self.correctAnswerIndex = correctAnswerIndex
	}
}

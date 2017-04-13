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
	var type: String?
	var limit: Int?
	var choices: [String]?
	var correctAnswerIndex: Int?

	init(question: String) {
		self.question = question
	}
}

class ChoiceQuestion: Question {
	init(question: String, choices: [String], correctAnswerIndex: Int) {
		super.init(question: question)
		self.choices = choices
		self.correctAnswerIndex = correctAnswerIndex
		self.type = "ChoiceQuestion"
	}
}

class VerbalQuestion: Question {
	init(question: String, limit: Int) {
		super.init(question: question)
		self.limit = limit
		self.type = "VerbalQuestion"
	}
}

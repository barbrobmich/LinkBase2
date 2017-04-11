//
//  ChallengeViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

	var questionIndex: Int = 0
	var questions: [Question] = []
	var company: Company?
	var currentQuestion: Question?
	
	@IBOutlet weak var questionNumberLabel: UILabel!
	@IBOutlet weak var questionTextLabel: UILabel!
	
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	@IBOutlet weak var button4: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		questions = (company?.questions)!
		
		currentQuestion = questions[questionIndex]
		questionNumberLabel.text = "\(questionIndex + 1)"
		
		questionTextLabel.text = currentQuestion?.question
		button1.setTitle("\((currentQuestion?.choices?[0])!)", for: UIControlState.normal)
		button2.setTitle("\((currentQuestion?.choices?[1])!)", for: UIControlState.normal)
		button3.setTitle("\((currentQuestion?.choices?[2])!)", for: UIControlState.normal)
		button4.setTitle("\((currentQuestion?.choices?[3])!)", for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func answerQuestion(index: Int) {
		if questionIndex == (questions.count - 1) {
			performSegue(withIdentifier: "finishChallenge", sender: nil)
			return
		}
		
		if index == currentQuestion?.correctAnswerIndex {
			print("correct")
		} else {
			print("wrong")
		}
		
		UIView.animate(withDuration: 0.2, animations: {
			self.questionNumberLabel.alpha = 0
			self.questionTextLabel.alpha = 0
			self.button1.alpha = 0
			self.button2.alpha = 0
			self.button3.alpha = 0
			self.button4.alpha = 0
		}) { (true) in
			UIView.animate(withDuration: 0.2, animations: {
				self.questionIndex += 1
				self.currentQuestion = self.questions[self.questionIndex]
				self.questionNumberLabel.text = "\(self.questionIndex + 1)"
				
				self.questionTextLabel.text = self.currentQuestion?.question
				self.button1.setTitle("\((self.currentQuestion?.choices?[0])!)", for: UIControlState.normal)
				self.button2.setTitle("\((self.currentQuestion?.choices?[1])!)", for: UIControlState.normal)
				self.button3.setTitle("\((self.currentQuestion?.choices?[2])!)", for: UIControlState.normal)
				self.button4.setTitle("\((self.currentQuestion?.choices?[3])!)", for: UIControlState.normal)
				
				self.questionNumberLabel.alpha = 1
				self.questionTextLabel.alpha = 1
				self.button1.alpha = 1
				self.button2.alpha = 1
				self.button3.alpha = 1
				self.button4.alpha = 1
			})
		}
	}
	
	
	@IBAction func select1(_ sender: Any) {
		answerQuestion(index: 0)
	}

	@IBAction func select2(_ sender: Any) {
		answerQuestion(index: 1)
	}
	
	@IBAction func select3(_ sender: Any) {
		answerQuestion(index: 2)
	}
	
	@IBAction func select4(_ sender: Any) {
		answerQuestion(index: 3)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

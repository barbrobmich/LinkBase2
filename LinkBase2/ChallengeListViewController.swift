//
//  ChallengeListViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ChallengeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var q1: Question = Question(question: "What is 1 + 1?", choices: ["1", "2", "3", "4"], correctAnswerIndex: 1)
	var q2: Question = Question(question: "What is 2 + 6?", choices: ["1", "2", "8", "4"], correctAnswerIndex: 2)
	var q3: Question = Question(question: "What is 7 + 4?", choices: ["1", "11", "3", "4"], correctAnswerIndex: 1)
	var q4: Question = Question(question: "What is 4 + 9?", choices: ["13", "2", "3", "4"], correctAnswerIndex: 0)
	var facebook: Company?
	var google: Company?
	var amazon: Company?
	var twitter: Company?
	var microsoft: Company?
	var companies: [Company] = []
	
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		facebook = Company(name: "Facebook", logo: UIImage(named: "facebook")!, questions: [q1, q2, q3, q4])
		google = Company(name: "Google", logo: UIImage(named: "google")!, questions: [q3, q4, q1, q2])
		twitter = Company(name: "Twitter", logo: UIImage(named: "twitter")!, questions: [q3, q4, q1, q2])
		microsoft = Company(name: "Microsoft", logo: UIImage(named: "microsoft")!, questions: [q3, q4, q1, q2])
		amazon = Company(name: "Amazon", logo: UIImage(named: "amazon")!, questions: [q3, q4, q1, q2])
		
		companies = [facebook!, google!, twitter!, microsoft!, amazon!]
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "company", for: indexPath) as! ChallengeTableViewCell
		let company  = companies[indexPath.row]
		print("company \(company)")
		cell.logoImageView.image = company.logo
		cell.nameLabel.text = company.name
		cell.questionCountLabel.text = "\(company.questions.count) questions"
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return companies.count
	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let cell = sender as! UITableViewCell
		let indexPath = tableView.indexPath(for: cell)
		let challengeDetailViewController = segue.destination as! ChallengeDetailViewController
		challengeDetailViewController.company = companies[indexPath!.row]
	}
}

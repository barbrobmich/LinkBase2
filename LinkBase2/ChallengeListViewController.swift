//
//  ChallengeListViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ChallengeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var question: Question?
	var facebook: Company?
	var companies: [Company] = []
	
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		question = Question(question: "What is 1 + 1?", choices: ["1", "2", "3", "4"], correctAnswerIndex: 1)
		facebook = Company(name: "Facebook", logo: UIImage(named: "facebook")!, questions: [question!, question!, question!])
		companies = [facebook!, facebook!, facebook!]
		
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

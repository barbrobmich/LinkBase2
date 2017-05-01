//
//  ChallengeListViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

class ChallengeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backgroundImage: UIImageView!

	var companies: [Company] = []

	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
		
        // test for background image
        addBlurToImage(image: backgroundImage, type: .light)
        
        
        tableView.delegate = self
		tableView.dataSource = self
        
        companies = Seed.getCustomers()
		
		tableView.reloadData()
    }

    // MARK: - TableView
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "company", for: indexPath) as! ChallengeTableViewCell
		let company  = companies[indexPath.row]
		cell.logoImageView.image = company.logo
        cell.logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        cell.logoImageView.clipsToBounds = true
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

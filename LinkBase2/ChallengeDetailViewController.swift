//
//  ChallengeDetailViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

	var company: Company?
	
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var questionCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = company?.name
		self.logoImageView.image = company?.logo
        self.logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.logoImageView.clipsToBounds = true
        
		questionCountLabel.text = "\((company?.questions.count)!) questions"
    }


    
	@IBAction func startChallenge(_ sender: Any) {
		
	}

 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let challengeViewController = segue.destination as! ChallengeViewController
		challengeViewController.company = company
    }


}

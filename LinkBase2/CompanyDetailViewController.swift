//
//  CompanyDetailViewController.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var compImg: UIImageView!
    @IBOutlet weak var compName: UILabel!
    @IBOutlet weak var pubicLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var numEmpLabel: UILabel!
    @IBOutlet weak var acqLab: UILabel!
    @IBOutlet weak var foundLabel: UILabel!
    @IBOutlet weak var compUrlLab: UILabel!
    @IBOutlet weak var compBlurb: UILabel!

    var company: Company!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.compName.text = self.company.name!
        self.compImg.image = self.company.logo!
        self.compImg.contentMode = UIViewContentMode.scaleAspectFit
        self.compImg.clipsToBounds = true
        self.pubicLabel.isHidden = !self.company.isPublic
        self.roundLabel.text = self.company.classifications.rawValue
        self.numEmpLabel.text = "\(self.company.numEmployees)"
        self.acqLab.text = "\(self.company.numOfAcquisitions)"
        self.foundLabel.text = self.company.founders?.joined(separator: ", ")
        self.compUrlLab.text = self.company.compUrl?.absoluteString
        self.compBlurb.text = self.company.compDescription!
        
        
        // show navigation
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.black

    }


    @IBAction func goToQuestion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CompanyChallenge") as! ChallengeDetailViewController
        controller.company = self.company
        self.present(controller, animated: true, completion: nil)
    }

}

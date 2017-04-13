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
    }


    @IBAction func goToQuestion(_ sender: Any) {
        
    }

}

//
//  CompanyDetailViewController.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var compName: UILabel!
    
    @IBOutlet weak var numEmployee: UILabel!
    
    
    var company: Company!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.compName.text = self.company.name!
        self.numEmployee.text = "\(self.company.numEmployees)"
    }



}

//
//  CompanyViewController.swift
//  LinkBase2
//
//  Created by Rob Hernandez on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    @IBOutlet weak var companyCollection: UICollectionView!
    var companies: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        companyCollection.delegate = self
        companyCollection.dataSource = self
        
        // Make temp Company data
        let tempCompany = [Company(name: "Uber", numEmployees: 100),
                           Company(name: "Coupa", numEmployees: 500),
                           Company(name: "Google", numEmployees: 9001)]
        self.companies = tempCompany
    }



    
    
    
    
    
    
    
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if let sender = sender as? CompanyCollectionCell{
            let vc = segue.destination as! CompanyDetailViewController
            vc.company = sender.company
        }
    }

}

extension CompanyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // First section is hello blurb
        if section == 0{
            return 1
            // Second section is Company Data
        }else if section == 1{
            return self.companies.count
        }else{
            // Third section is optional(Trending)
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.companyCollection.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCollectionCell
        let company = self.companies[indexPath.row]
        cell.company = company
        return cell
    }
    
    
}

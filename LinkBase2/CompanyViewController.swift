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
    @IBOutlet weak var searchController: UISearchBar!
    var scope: String = "All"

    var companies: [Company] = []
    var filteredCompanies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        companyCollection.delegate = self
        companyCollection.dataSource = self
        
        // set up searchController
        self.searchController.showsScopeBar = true
        self.searchController.scopeButtonTitles = ["All", "Startup", "Public", "Series A", "Series C"]
        self.searchController.selectedScopeButtonIndex = 0
        self.searchController.barStyle = UIBarStyle.blackTranslucent
        self.searchController.delegate = self
        self.searchController.sizeToFit()
        
        //hide nav bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        // Get Company Data   
    
        
        self.companies = Seed.getCustomers()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        // On Return from detail page
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            return 0
            // Second section is Company Data
        }else if section == 1{
            if self.scope == "All" && (self.searchController.text?.isEmpty)!{
                return self.companies.count
            }else{
                return self.filteredCompanies.count
            }
            
        }else{
            // Third section is optional(Trending)
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.companyCollection.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCollectionCell
        let company: Company
        if self.scope == "All" && (self.searchController.text?.isEmpty)!{
            company = self.companies[indexPath.row]
        }else{
            company =  self.filteredCompanies[indexPath.row]
        }
        cell.company = company
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 20), height: CGFloat(100))
    }
}
// Searches on the company table based on input change
extension CompanyViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText: searchText, scope: self.scope)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //scope is updated here
        self.scope = searchBar.scopeButtonTitles![selectedScope]
        filterContentForSearchText(searchText: searchBar.text!, scope: self.scope)
    }
    

    // TODO: make it so that when you select a button, it filters that. Can't seem to make that work
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        
        self.filteredCompanies = self.companies.filter({ (company: Company) -> Bool in
            var filterCondition: Bool
            
            switch scope {
            
            case "All":
                filterCondition = true
                
            case "Startup":
                
                filterCondition =  (company.isPublic == false)

            case "Public":
                
                filterCondition =  (company.isPublic == true)

            case "Series A":
                filterCondition = (company.classifications == .seriesA)

            case "Series C":
                filterCondition = (company.classifications == .seriesC)

            default:
                filterCondition = false

            }
            
            if searchText.isEmpty{
                return filterCondition
            }else{
                return filterCondition && company.name!.range(of: searchText, options: .caseInsensitive) != nil
            }
            
        })
        
        self.companyCollection.reloadData()
    }
}

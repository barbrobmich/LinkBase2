//
//  HomeViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var quoteOfDay: UILabel!
    @IBOutlet weak var compOfTheDayImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var homeChallengeCollectionView: UICollectionView!

	var companies: [Company] = []
	var filteredCompanies: [Company] = []
	var completedChallenges: [String] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBarItem.selectedImage = UIImage(named: "home")

        styleBackgroundImage()
		homeChallengeCollectionView.dataSource = self
		homeChallengeCollectionView.delegate = self
		homeChallengeCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        // Seed the collectionView With Customers
		companies = Seed.getCustomers()

		homeChallengeCollectionView.reloadData()
        
        // Setup Company of the day
        let randomCompany = companies.randomElement()
        self.compOfTheDayImg.image = randomCompany?.logo
        self.compOfTheDayImg.contentMode = UIViewContentMode.scaleAspectFit
        self.compOfTheDayImg.clipsToBounds = true
        
        // Set up Quote of the day
        let quoteOfTheDay = getQuote()
        self.quoteOfDay.text = quoteOfTheDay
        
        // Set up Current User name
        let name = PFUser.current()?.object(forKey: "firstname") as? String
        self.usernameLabel.text = name

    }
	
	override func viewWillAppear(_ animated: Bool) {
		filterChallenges()
	}
	
	func filterChallenges() {
		print("filtering companies")
		let query = PFQuery(className: "User")
		query.includeKey("current")
		
		query.findObjectsInBackground { (res: [PFObject]?, error) in
			let user = res?[0]
			PFUser.setValue(user?.value(forKey: "completedChallenges"), forKey: "completedChallenges")
		}
		
		if let challenges = PFUser.current()?.value(forKey: "completedChallenges") {
			print("challeneges: \(challenges)")
			completedChallenges = challenges as! [String]
			filteredCompanies = companies.filter({ (company) -> Bool in
				return !completedChallenges.contains(company.name!)
			})
		} else {
			self.filteredCompanies = companies
		}
		print("reloading data")
		homeChallengeCollectionView.reloadData()
	}
	
    func getQuote() -> String{
        return ["One important key to success is self-confidence. An important key to self-confidence is preparation.” –Arthur Ashe",
                "Find out what you like doing best and get someone to pay you for doing it.” –Katherine Whitehorn",
                "You miss 100% of the shots you don’t take.”–Wayne Gretzky",
                "Opportunities don't often come along. So, when they do, you have to grab them.” –Audrey Hepburn",
                "“Choose a job you love, and you will never have to work a day in your life.” –Confucius"].randomElement()!
    }

    func styleBackgroundImage() {

        // Add blur effect to background image
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = backgroundImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)

    }

    @IBAction func onLogout(_ sender: UIButton) {
        print("Logging Out")
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogOut"), object: nil)
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let indexPath = homeChallengeCollectionView.indexPath(for: sender as! UICollectionViewCell)
		let controller = segue.destination as! ChallengeDetailViewController
		controller.company = filteredCompanies[(indexPath?.row)!]
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return filteredCompanies.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeChallengeCollectionCell", for: indexPath) as! HomeChallengeCollectionCell

		cell.challengeImageView.image = filteredCompanies[indexPath.row].logo
        cell.challengeNameLabel.text = filteredCompanies[indexPath.row].name

        return cell

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    

}

extension Collection where Index == Int {
    
    /**
     Picks a random element of the collection.
     
     - returns: A random element of the collection.
     */
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
    
}

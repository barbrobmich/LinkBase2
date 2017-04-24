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

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var homeChallengeCollectionView: UICollectionView!

	var companies: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        styleBackgroundImage()
		homeChallengeCollectionView.dataSource = self
		homeChallengeCollectionView.delegate = self
		homeChallengeCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        // Do any additional setup after loading the view.
		companies = Seed.getCustomers()
		homeChallengeCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
		
    }
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeChallengeCollectionCell", for: indexPath as IndexPath) as! HomeChallengeCollectionCell

		return cell
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
		controller.company = companies[(indexPath?.row)!]
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return companies.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeChallengeCollectionCell", for: indexPath) as! HomeChallengeCollectionCell

		cell.challengeImageView.image = companies[indexPath.row].logo
        cell.challengeNameLabel.text = companies[indexPath.row].name

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		let cell = homeChallengeCollectionView.cellForItem(at: indexPath) as! HomeChallengeCollectionCell
//		let sb = UIStoryboard(name: "Challenge", bundle: nil)
//		let controller = sb.instantiateViewController(withIdentifier: "CompanyChallenge")
//		self.present(controller, animated: true, completion: nil)
		
//		var mainView: UIStoryboard!
//		mainView = UIStoryboard(name: "Home", bundle: nil)
//		let viewcontroller = mainView.instantiateViewController(withIdentifier: "CompanyChallenge") as! ChallengeDetailViewController
//		viewcontroller.company = companies[indexPath.row]
//		self.view.window?.rootViewController = viewcontroller
//		self.tabBarController?.selectedIndex = 1
//		self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}


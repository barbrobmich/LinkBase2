//
//  DashboardViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

class DashboardViewController: UIViewController {


    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var itemCollectionView: UICollectionView!
    let itemCollectionIdentifier = "DashboadItemCell"

    var currentUser: PFUser!

    // Challenge section placeholder labels -- to be udpated

    @IBOutlet weak var numChallengesCompleted: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    let challengeCollectionIdentifier = "ChallengeCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = PFUser.current()

        addBlurToImage(image: backgroundImageView, type: .extraLight)

        itemCollectionView.delegate = self
        challengeCollectionView.delegate = self

        itemCollectionView.dataSource = self
        challengeCollectionView.dataSource = self

        firstNameTextField.text = currentUser.object(forKey: "firstname") as? String
        lastNameTextField.text = currentUser.object(forKey: "lastname") as? String
        emailTextField.text = currentUser.email
        print("First name: \(firstNameTextField.text!)")
        print("currentUser: \(currentUser.username!)")


    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.itemCollectionView {
            return 3 // replace with items.count
        } else {
            return 5 // replace with challenges.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.itemCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardItemCell", for: indexPath) as! DashboardItemCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeCollectionIdentifier, for: indexPath) as UICollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

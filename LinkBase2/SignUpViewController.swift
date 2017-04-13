//
//  SignUpViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // add styling to elements
        addBlurToImage(image: backgroundImageView, type: .light)
        signUpButton.layer.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.29, blue: 0.37, alpha: 1.0).cgColor

           self.hideKeyboard()
    }
    
    func addNameToParse(firstName: String, lastName: String){
        let user = PFUser.current()
        user!.setObject(firstName, forKey: "firstname")
        user!.setObject(lastName, forKey: "lastname")
        user!.saveInBackground()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidSignUp"), object: nil)
    }


    @IBAction func didSignUp(_ sender: UIButton) {
        print("tapped on Sign Up")

        let user = PFUser()
        user.email = emailTextField.text
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.signUpInBackground {(success, error) in
            if let _ = error {
                print("could not sign up user")
            } else {
                print("did create user with name \(user.username!)")
                self.addNameToParse(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!)
            }
        }


    }

    @IBAction func onBack(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        self.present(controller, animated: true, completion: nil)
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



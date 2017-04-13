//
//  LoginViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up styling
        addBlurToImage(image: backgroundImageView, type: .light)
        loginButton.layer.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.29, blue: 0.37, alpha: 1.0).cgColor
        createAccountButton.setTitleColor(UIColor(colorLiteralRed: 0.2, green: 0.29, blue: 0.37, alpha: 1.0), for: .normal)

           self.hideKeyboard()
    }


    @IBAction func onLogin(_ sender: UIButton) {
        print("Tapped on login")

        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                print("did log in \(user!.username!)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogIn"), object: nil)
            } else if let error = error {
                print("error: \(error)")
            }
        }
    }


    @IBAction func onCreateAccount(_ sender: UIButton) {
        print("Going to sign up new account")
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

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

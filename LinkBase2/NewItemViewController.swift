//
//  NewItemViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class NewItemViewController: UIViewController {


    @IBOutlet weak var backgroundImageView: UIImageView!
    var langPopupViewController: ChooseLangViewController!
    @IBOutlet weak var selectLangView: UIView!

    // Date Pickers


    @IBOutlet weak var fromDatePicker: UIPickerView!
    @IBOutlet weak var toDatePicker: UIPickerView!
    var fromPicker: MonthYearPickerView!
    var toPicker: MonthYearPickerView!

    var fromDate: Int!
    var toDate: Int!

    // Photo Properties
    var onPhotoTap: UITapGestureRecognizer!
    var image: UIImage!
    var imageDidChange: Bool?

    // Data
    var categories = [Item.category.Education, Item.category.Professional, Item.category.Community, Item.category.Other]
    var index: Int!


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var selectLanguagesButton: UIButton!
    @IBOutlet weak var selectedLanguagesLabel: UILabel!



    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // add styling to view
        addBlurToImage(image: backgroundImageView, type: .light)
        itemImageView.layer.cornerRadius = 3

        // nav bar styling
        let navBar = self.navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        self.navigationItem.title = "Add \(categories[index]) Item"
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]


        // load elements
        self.hideKeyboard()
        //Notes on language section.
        //When empty, show button to click here to select languages
        // mylanguage collectionview is hidden
        // if language is selected, add it to the collection view
        //if languages exist display
        // pop up show icons

        // load Photo related elements
    //    getCurrentUserImage()
        imageDidChange = false
        onPhotoTap = UITapGestureRecognizer(target: self, action: #selector(self.getPhoto(_:)))
        itemImageView.addGestureRecognizer(onPhotoTap)
        itemImageView.isUserInteractionEnabled = true

        // load datepicker

        fromPicker = MonthYearPickerView()
        toPicker = MonthYearPickerView()
        fromPicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
        }

        toPicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
        }
    }

    // MARK: - ACTIONS





     // MARK: - PHOTO IMAGE RELATED METHODS

//    func getCurrentUserImage() {
//
//        let image = PFImageView()
//
//        let currentUser = PFUser.current() // change this when user is implementd
//        if currentUser["item_image"] != nil {
//            //   myImage.file = currentUser["profile_image"] as? PFFile
//            image.file = currentUser.object(forKey: "item_image") as? PFFile
//            image.loadInBackground()
//        } else {
//            image.image = UIImage(named: "itemPlaceholder")!
//        }
//        itemImageView.image = myImage.image
//        itemImageView.clipsToBounds = true
//        itemImageView.layer.cornerRadius = 15
//    }

    func getPhoto(_ sender: UITapGestureRecognizer){
        print("Getting the photo")
        pickPhoto()
    }


//    func postItemImageToParse() {
//
//        User.saveProfileImage(image: itemImageView.image) { (success: Bool, error: Error?) -> Void in
//            if success {
//                print("Successful Post to Parse")
//            }
//            else {
//                print("Can't post to parse")
//            }
//        }
//    }



    // MARK: - LANGUAGES SECTION
    @IBAction func showLanguagePopup(_ sender: UIButton) {
        print("did select show language")

        self.langPopupViewController = ChooseLangViewController(nibName: "ChooseLang", bundle: nil)
        self.langPopupViewController.showInView(aView: self.view, animated: true)

        //self.langPopupViewController.showInView(aView: self.view, withMessage: "Select Language", animated: true)
       // self.present(self.langPopupViewController, animated: true, completion: nil)

    }


    // MARK: - NAVIGATION

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    @IBAction func goBack(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddItem") as! AddItemViewController
        self.present(controller, animated: true, completion: nil)
    }


}



extension NewItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func takePhotoWithCamera() {

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        image = info[UIImagePickerControllerEditedImage] as? UIImage
        print("did pick the image")

        if let theImage = image{
            print("Going to show the image")
            imageDidChange = true
            self.itemImageView.image = theImage
            self.reloadInputViews()
        }

        //tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)
    }

    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        }
        else {
            choosePhotoFromLibrary()
        }
    }

    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {_ in self.takePhotoWithCamera() })
        alertController.addAction(takePhotoAction)

        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: {_ in self.choosePhotoFromLibrary() })

        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }

}


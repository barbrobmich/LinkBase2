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
import MBProgressHUD


class NewItemViewController: UIViewController, SelectedLangaugesDelegate{


    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var selectLangView: UIView!
    @IBOutlet weak var opaqueView: UIView!
    
    // Date Picker Properties
    @IBOutlet weak var fromDatePicker: MonthYearPickerView!
    @IBOutlet weak var toDatePicker: MonthYearPickerView!

    // Photo Properties
    var onPhotoTap: UITapGestureRecognizer!
    var image: UIImage!
    var imageDidChange: Bool?

    // Data
    var item: Item!
    var categories = [Item.category.Education, Item.category.Professional, Item.category.Community, Item.category.Other]
    var index: Int!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var roleDescription: UITextView!
    @IBOutlet weak var selectLanguagesButton: UIButton!
    @IBOutlet weak var selectedLanguagesLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!

    var languages: [String] = ["C++", "Go", "Haskell", "Java", "Javascript", "Objective C", "Prolog", "Python", "R", "Ruby", "SQL", "Swift"]
    var langImages = [(#imageLiteral(resourceName: "cpp")), (#imageLiteral(resourceName: "go")), (#imageLiteral(resourceName: "haskell")), (#imageLiteral(resourceName: "java")), (#imageLiteral(resourceName: "javascript")), (#imageLiteral(resourceName: "objectiveC")), (#imageLiteral(resourceName: "prolog")), (#imageLiteral(resourceName: "python")), (#imageLiteral(resourceName: "R")), (#imageLiteral(resourceName: "ruby")), (#imageLiteral(resourceName: "sql")), (#imageLiteral(resourceName: "swift"))]
    var mySelectedLanguages: [Int] = []
    

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
        opaqueView.layer.cornerRadius = 3
        selectLanguagesButton.layer.cornerRadius = 3 

        // nav bar styling
        let navBar = self.navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        self.navigationItem.title = "Add \(categories[index]) Item"
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        doneButton.tintColor = UIColor.white


        // load elements
        self.hideKeyboard()
        imageDidChange = false
        onPhotoTap = UITapGestureRecognizer(target: self, action: #selector(self.getPhoto(_:)))
        itemImageView.addGestureRecognizer(onPhotoTap)
        itemImageView.isUserInteractionEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self 
        
        item = Item()
    }
    

    // MARK: - ALERT ACTIONS

    func showAlert() {
        print("showing alert")
        
        let alert = UIAlertController(title: "Saved Item", message: "Add New Item or Continue to App?", preferredStyle: .alert)
        
        let addNewAction = UIAlertAction(title: "Add New", style: .default, handler: { (action) -> Void in
            print("going to addNewVC")
            let storyboard = UIStoryboard(name: "Signup", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AddItem")
            self.present(controller, animated: true, completion: nil)
        })
    
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            print("Going to HomeVC")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        })
        
        alert.addAction(addNewAction)
        alert.addAction(continueAction)
        present(alert, animated: true, completion: nil)
    }

     // MARK: - PHOTO IMAGE RELATED METHODS

    func getPhoto(_ sender: UITapGestureRecognizer){
        print("Getting the photo")
        pickPhoto()
    }


    // MARK: - LANGUAGES SECTION
    @IBAction func showLanguagePopup(_ sender: UIButton) {
        print("did select show language")
        
        let popOverVC = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "Language") as! LangSelectionViewController
        popOverVC.selectLangDelegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func didSelectLangauge(myLanguages: [Int]) {
        
        print("Selected the following: \(myLanguages)")
        mySelectedLanguages = myLanguages
        print("My langauges are: \(mySelectedLanguages)")
        self.collectionView.reloadData()
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

    
    @IBAction func onDoneTap(_ sender: UIButton) {
        item.name = nameTextField.text
        item.user = PFUser.current()
        item.url = URLTextField.text
        item.role = roleDescription.text
        
        item.fromMonth = fromDatePicker.month
        item.fromYear = fromDatePicker.year
        item.toMonth = toDatePicker.month
        item.toYear = toDatePicker.year
        item.languages = mySelectedLanguages
        item.category = String(describing: categories[index])
        
        print("From: \(fromDatePicker.month) / \(fromDatePicker.year) to: \(item.toMonth) / \(item.toYear)")
    
        
        item.itemImageFile = Item.getPFFileFromImage(image: itemImageView.image)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Item.postItemToParse(item: item){ (success: Bool, error: Error?) -> Void in
            if success {
                print("Successful Post to Parse")
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showAlert()
            }
            else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Can't post to parse")
            }
        }
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

extension NewItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mySelectedLanguages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectLanguageCell", for: indexPath) as! SelectLanguageCell
        
        let index = mySelectedLanguages[indexPath.item]
        print("index: \(index)")
        
        cell.languageNameLabel.text = languages[index]
        cell.languageImageView.image = langImages[index]
        
        cell.isUserInteractionEnabled = true
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print("selected item at \(indexPath.item)")
      //  let cell = collectionView.cellForItem(at: indexPath) as? SelectLanguageCell
      //  let name = cell?.languageNameLabel.text
      //  print("selected \(name!)")
        
    }
    
    
}


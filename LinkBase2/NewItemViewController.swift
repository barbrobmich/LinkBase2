//
//  NewItemViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var langPopupViewController: ChooseLangViewController!
    @IBOutlet weak var selectLangView: UIView!
    

    var categories = [Item.category.Education, Item.category.Professional, Item.category.Community, Item.category.Other]
    var index: Int!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var languagesContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var selectLanguagesButton: UIButton!
    
    @IBOutlet weak var fromMonth: UIPickerView!
    @IBOutlet weak var toMonth: UIPickerView!
    @IBOutlet weak var fromYear: UIPickerView!
    @IBOutlet weak var toYear: UIPickerView!
    
    
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
        
        // nav bar styling
        let navBar = self.navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        self.navigationItem.title = "Add \(categories[index]) Item"
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        
        // load elements 
        //Notes on language section. 
        //When empty, show button to click here to select languages
        // mylanguage collectionview is hidden
        // if language is selected, add it to the collection view
        //if languages exist display 
        // pop up show icons 
        
        
        
    
        
    }
    
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddItem") as! AddItemViewController
        self.present(controller, animated: true, completion: nil)
    }
    

}


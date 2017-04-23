//
//  LanguageItemViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/22/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LanguageItemViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var categoryItems: [CategoryItem] = []
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var lang: Language!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // nav bar styling
        let leftButton = UIBarButtonItem(image: UIImage(named: "back32white"), style: .plain, target: self, action: #selector(onGoBack(_:)))
        leftButton.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem = leftButton
        let navBar = self.navigationController?.navigationBar
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        
        let rightButton: UIButton = UIButton.init(type: .custom)
        //set image for button
        rightButton.setImage(lang.langImage, for: UIControlState.normal)
        //set frame
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.layer.cornerRadius = 3
        let barButton = UIBarButtonItem(customView: rightButton)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.title = String(describing: lang.langName!)
        
        self.backgroundImage.image = lang.langImage
        addBlurToImage(image: backgroundImage, type: .extraLight)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("displaying: \(lang.langName!) with \(lang.langCategories!.count) categories")
        
        for category in lang.langCategories! {
            
            var catItem = CategoryItem(category: category, items: [])
            
            for item in lang.items! {
                if item.category == category {
                    catItem.items.append(item)
                }
            }
            categoryItems.append(catItem)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onGoBack(_ sender: UIButton) {
         
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        controller.selectedIndex = 3
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
}

extension LanguageItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categoryItems[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageItemCell", for: indexPath) as! LanguageItemCell
        cell.item = categoryItems[indexPath.section].items[indexPath.row]
        print("Cell item is \(cell.item.name!)")
        cell.itemNameLabel.text = cell.item.name!
        cell.itemUrlLabel.text = cell.item.url!
        cell.itemRoleLabel.text = cell.item.role!
        cell.itemDatesLabel.text = String(describing: cell.item["from_month"]!) + "/" + String(describing: cell.item["from_year"]!) + " to " + String(describing: cell.item["to_month"]!) + "/" + String(describing: cell.item["to_year"]!)
       
        if let file: PFFile = categoryItems[indexPath.section].items[indexPath.row]["item_imageFile"] as? PFFile {
            print("File is \(file)")
            cell.itemImageView.file = file 
            cell.itemImageView.loadInBackground()
        }

        
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        for _ in categoryItems {
            return categoryItems[section].category
        }
        
        return nil
    }
}

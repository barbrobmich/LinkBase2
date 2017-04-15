//
//  AddItemViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlurToImage(image: backgroundImageView, type: .light)

        tableView.dataSource = self
        tableView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    

    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }

}



extension AddItemViewController: DidSelectItem {
   
    func didSelectCategory(tag: Int) {
        print("Did select category")
        print("tag: \(tag)")
        let newItemVC = self.storyboard?.instantiateViewController(withIdentifier: "NewItem") as? NewItemViewController
        newItemVC?.index = tag
        let navController = UINavigationController(rootViewController: newItemVC!)
        self.present(navController, animated: true, completion: nil)
    }
}

extension AddItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        if indexPath.section == 0 {
            cell.cellSection = 1
            cell.items = items
        } else {
            cell.cellSection = 2
            cell.selectItemDelegate = self 
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section%2 == 0) ? "My Items":"Categories"
    }
}

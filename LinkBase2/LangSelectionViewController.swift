//
//  LangSelectionViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/19/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

protocol SelectedLangaugesDelegate {
    
    func didSelectLangauge(myLanguages: [Int])
}

class LangSelectionViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var opaqueView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var languages: [String] = ["C++", "Go", "Haskell", "Java", "Javascript", "Objective C", "Prolog", "Python", "R", "Ruby", "SQL", "Swift"]
    
    var langImages = [(#imageLiteral(resourceName: "cpp")), (#imageLiteral(resourceName: "go")), (#imageLiteral(resourceName: "haskell")), (#imageLiteral(resourceName: "java")), (#imageLiteral(resourceName: "javascript")), (#imageLiteral(resourceName: "objectiveC")), (#imageLiteral(resourceName: "prolog")), (#imageLiteral(resourceName: "python")), (#imageLiteral(resourceName: "R")), (#imageLiteral(resourceName: "ruby")), (#imageLiteral(resourceName: "sql")), (#imageLiteral(resourceName: "swift"))]
    
    var selectedLanguages: [Int] = []
    var selectLangDelegate: SelectedLangaugesDelegate?
    
    override func viewDidLoad() {
        self.collectionView.allowsMultipleSelection = true
        super.viewDidLoad()
      
        
        addBlurToImage(image: backgroundView, type: .regular)
        backgroundView.alpha = 0.5
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.doneButton.layer.cornerRadius = 3
        self.cancelButton.layer.cornerRadius = 3
        self.opaqueView.layer.cornerRadius = 5
    
        self.showAnimate()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 3
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false 
    }

    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished: Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }
    
    
    
    @IBAction func onDoneTap(_ sender: UIButton) {
        print("Tapped on done")
        self.selectLangDelegate?.didSelectLangauge(myLanguages: selectedLanguages)
        self.removeAnimate()
    }
    
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.removeAnimate()
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

extension LangSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return languages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectLanguageCell", for: indexPath) as! SelectLanguageCell
        
        cell.languageNameLabel.text = languages[indexPath.item]
        cell.languageImageView.image = langImages[indexPath.item]
        cell.isUserInteractionEnabled = true
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // print("selected item at \(indexPath.item)")
        let cell = collectionView.cellForItem(at: indexPath) as? SelectLanguageCell
        cell?.layer.cornerRadius = 3
        cell?.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        let name = cell?.languageNameLabel.text
        cell?.languageNameLabel.textColor = UIColor.red
        print("selected \(name!)")
        selectedLanguages.append(indexPath.item)
        
    }
    
    
}



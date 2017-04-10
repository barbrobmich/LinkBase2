//
//  ChooseLangViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/9/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class ChooseLangViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var cellIdentifier = "PickLanguageCollectionCell"
    let objects = ["Cat","Dog","Fish"]
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // collectionView.register(UINib(nibName: "PickLanguageCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.red
        
        
        messageLabel.text = "Select Languages"
//        self.cancelButton.layer.cornerRadius = 3
//        self.cancelButton.layer.backgroundColor = UIColor.yellow.cgColor
//        self.doneButton.layer.cornerRadius = 3
//        self.doneButton.layer.backgroundColor = UIColor.yellow.cgColor
//        // Do any additional setup after loading the view.
        
         //self.Lang.showInView(aView: self.view, animated: true)
    }

    func showInView(aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
    }
    
//    func layoutCells() {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        layout.minimumInteritemSpacing = 5.0
//        layout.minimumLineSpacing = 5.0
//        layout.itemSize = CGSize(width: 120, height: 120)
//      //  layout.itemSize = CGSize(width: (UIScreen.mainScreen().bounds.size.width - 40)/3, height: ((UIScreen.mainScreen().bounds.size.width - 40)/3))
//        collectionView!.collectionViewLayout = layout
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onDone(_ sender: UIButton) {
        print("Tapped on Done")
    }
    
    
    @IBAction func onCancel(_ sender: UIButton) {
        print("tapped on cancel")
    }

}

extension ChooseLangViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return self.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UICollectionViewCell
//    
//       cell.langNameLabel.text = self.objects[indexPath.item]
//        
//        print("Cell name: \(self.objects[indexPath.item])")
//        print("Name in cell: \(cell.langNameLabel.text!)")
//        print("Name label in cell is \(cell.langNameLabel!)")
        
        
  
        return cell
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item \(indexPath.item)")
    }

}



//
//  DashboardViewController.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class DashboardViewController: UIViewController {


    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var profileImage: PFImageView!

    @IBOutlet weak var itemCollectionView: UICollectionView!
    let itemCollectionIdentifier = "DashboadItemCell"
    var items: [Item] = []
    
    var onPhotoTap: UITapGestureRecognizer!
    var image: UIImage!
    var imageDidChange: Bool?

    var currentUser: PFUser!

    // Challenge section placeholder labels -- to be udpated

    @IBOutlet weak var numChallengesCompleted: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    let challengeCollectionIdentifier = "ChallengeCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = PFUser.current()
  
        addBlurToImage(image: backgroundImageView, type: .extraLight)
        
        imageDidChange = false
        onPhotoTap = UITapGestureRecognizer(target: self, action: #selector(self.getPhoto(_:)))
        profileImage.addGestureRecognizer(onPhotoTap)
        profileImage.isUserInteractionEnabled = true


        itemCollectionView.delegate = self
        challengeCollectionView.delegate = self

        itemCollectionView.dataSource = self
        challengeCollectionView.dataSource = self
        
        firstNameTextField.text = currentUser.object(forKey: "firstname") as? String
        lastNameTextField.text = currentUser.object(forKey: "lastname") as? String
        emailTextField.text = currentUser.email
        print("First name: \(firstNameTextField.text!)")
        print("currentUser: \(currentUser.username!)")

        fetchItems()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !imageDidChange! {
            loadUserImage()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageDidChange = false
    }
    
    // FETCHING ITEMS FROM PARSE

    func fetchItems() {
        
        let query = PFQuery(className: Item.parseClassName())
        
        query.order(byDescending: "_created_at")
        query.whereKey("user", equalTo: PFUser.current()?.username!)
        query.limit = 20
        query.findObjectsInBackground { (parseItems: [PFObject]?, error: Error?) -> Void in
            
            if let myItems = parseItems {
                for item in myItems {
                    if item is Item {
                    }
                    if let item = item as? Item {
                        self.items.insert(item, at: 0)
                    }
                }
                self.itemCollectionView.reloadData()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
    func loadUserImage() {

        profileImage.image = UIImage(named: "greyProfile32")
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 15
        
        if let file: PFFile = PFUser.current()?["profile_image"] as? PFFile {
            profileImage.file = file
            profileImage.loadInBackground()
        }
    }


    // MARK: - PHOTO RELATED METHODS
    func getPhoto(_ sender: UITapGestureRecognizer){
        print("Getting the photo")
        pickPhoto()
    }
    
    func saveProfileImage(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
            currentUser["profile_image"] = getPFFileFromImage(image: image) // PFFile column type
            currentUser.saveInBackground(block: completion)
        }
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
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

extension DashboardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            self.profileImage.image = theImage
            self.saveProfileImage(image: profileImage.image){ (success: Bool, error: Error?) -> Void in
                if success {
                    print("Successful Post to Parse")
                }
                else {
                    print("Can't post to parse")
                }
            }
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


extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.itemCollectionView {
            return items.count
        } else {
            return 5 // replace with challenges.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.itemCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardItemCell", for: indexPath) as! DashboardItemCell
            cell.itemNameLabel.text = items[indexPath.item].name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: challengeCollectionIdentifier, for: indexPath) as UICollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

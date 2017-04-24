//
//  HomeChallengeCollectionCell.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/12/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit

class HomeChallengeCollectionCell: UICollectionViewCell {


    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.challengeImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.challengeImageView.clipsToBounds = true
    }

}

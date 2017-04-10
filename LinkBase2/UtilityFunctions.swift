//
//  UtilityFunctions.swift
//  LinkBase2
//
//  Created by Barbara Ristau on 4/8/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VISUAL EFFECTS

func addBlurToImage(image: UIImageView, type: UIBlurEffectStyle) {
    
    // Adds blur effect to background image
    let blurEffectStyle = type
    let blur = UIBlurEffect(style: blurEffectStyle)
    let blurEffectView = UIVisualEffectView(effect: blur)
    blurEffectView.frame = image.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    image.addSubview(blurEffectView)
    
}
    

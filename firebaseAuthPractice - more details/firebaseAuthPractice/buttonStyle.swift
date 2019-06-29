//
//  buttonStyle.swift
//  firebaseAuthPractice
//
//  Created by Nasser Jeary on 2019-06-10.
//  Copyright © 2019 Nasser Jeary. All rights reserved.
//

import Foundation
import UIKit

class BorderedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 21
        clipsToBounds = true
      
    }
}

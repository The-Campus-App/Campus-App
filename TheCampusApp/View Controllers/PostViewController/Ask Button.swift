//
//  Ask Button.swift
//  TheCampusApp
//
//  Created by Yogesh Kumar on 05/10/19.
//  Copyright © 2019 Harsh Motwani. All rights reserved.
//

import UIKit

// MARK:- PostViewController Extension #3
// Ask Question
extension PostViewController{
    // This functions check if input text field in valid
    func checkValidInput(_ text: inout String){
        if text.count > 0{
            askButton.isEnabled = true
            askButton.backgroundColor = blueColorDark
        }
        else{
            askButton.isEnabled = false
            askButton.backgroundColor = blueColorFaint
        }
    }
    
}
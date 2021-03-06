////
////  Rich Text Editor.swift
////  TheCampusApp
////
////  Created by Yogesh Kumar on 05/10/19.
////  Copyright © 2019 Harsh Motwani. All rights reserved.
////
//
//import UIKit
//
//
//// MARK:- PostViewController Extension #4
//// Text Editor
//extension PostViewController : UITextViewDelegate{
//    // Manage placeholders showing and hiding
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String)->Bool{
//        guard let textView = textView as? PlaceholderTextView else {return true}
//        let newLength = textView.text.utf16.count + text.utf16.count - range.length
//        let deletedText = textView.text(in: textView.toTextRange(NSRange: range))
//        let isDeleted = (deletedText!.count != 0)
//        handlePlaceholder(textView, newLength)
//        return textOptionsView.changeText(textView, text, deletedText, isDeleted)
//    }
//
//    func handlePlaceholder(_ textView: PlaceholderTextView, _ length: Int){
//        if length > 0{
//            if(!textView.placeholderLabel.isHidden){
//                textView.placeholderLabel.isHidden = true
//                textView.textContainerInset.bottom -= 24
//            }
//        }
//        else{
//            if(textView.placeholderLabel.isHidden){
//                textView.placeholderLabel.isHidden = false
//                textView.textContainerInset.bottom += 24
//            }
//        }
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//        checkValidInput(textView.attributedText.length)
//        textOptionsView.textViewDidChange(textView)
//    }
//}
//

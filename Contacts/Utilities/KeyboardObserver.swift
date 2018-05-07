//
//  KeyboardObserver.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation
import UIKit


protocol KeyboardObserver {
    var container:UIView{get}
}

extension KeyboardObserver{
    
    func registerForKeyboardNotifications(shouldRegister:Bool) {
        
        var willShowObserver:NSObjectProtocol?
        var willHideObserver:NSObjectProtocol?
        
        if shouldRegister{
            willShowObserver =   NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: handler(notification:))
            
            willHideObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: handler(notification:))
        } else {
            
            if let observer1 = willShowObserver, let observer2 = willHideObserver{
                NotificationCenter.default.removeObserver(observer1)
                NotificationCenter.default.removeObserver(observer2)
            }
        }
        
    }
    
    //Utility function
    func findFirstResponder(inView view: UIView) -> UIView? {
        for subView in view.subviews  {
            if subView.isFirstResponder {
                return subView
            }
            
            if let recursiveSubView = self.findFirstResponder(inView: subView) {
                return recursiveSubView
            }
        }
        
        return nil
    }
    
    fileprivate func animateViewWith(sender:UIView, notification:Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        let firstResponder = findFirstResponder(inView: container)
        
        let up = notification.name == NSNotification.Name.UIKeyboardWillShow ? true : false
        
        if let firstResponder = firstResponder{
            
            let movementDuration:TimeInterval = animationDuration
            UIView.beginAnimations( "animateView", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration )
            
            let frame = firstResponder.convert(firstResponder.frame, to: container)
            let visibleContainerHeight = container.frame.height - keyboardRect.height
            //            print(keyboardRect.height)
            let firstResponderPosition = frame.origin.y + frame.height
            
            let offsetY = visibleContainerHeight - firstResponderPosition
            
            if up{
                
                if firstResponderPosition > visibleContainerHeight && !(sender is UIScrollView) {
                    container.transform = CGAffineTransform(translationX: 0, y: offsetY)
                }
                
                if sender is UIScrollView{
                    (sender as! UIScrollView).contentInset = UIEdgeInsetsMake(0, 0,
                                                                              keyboardRect.height + 10, 0)
                    
                    var frame:CGRect
                    
                    if let  rect =   firstResponder.superview?.convert(firstResponder.frame, to: container){
                        frame = rect
                    } else{
                        frame = firstResponder.frame
                    }
                    
                    (sender as! UIScrollView).scrollRectToVisible(frame.offsetBy(dx: 0, dy: 10), animated: true)
                }
                
            } else {
                
                if sender is UIScrollView{
                    (sender as! UIScrollView).contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                } else /*if firstResponderPosition > visibleContainerHeight*/ {
                    container.transform = CGAffineTransform.identity
                }
            }
            UIView.commitAnimations()
        }
    }
    
    fileprivate func handler(notification:Notification){
        animateViewWith(sender: container, notification: notification)
    }
}

//
//  AddOrEditContactView.swift
//  Contacts
//
//  Created by Nithin on 07/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

class AddOrEditContactView: UIViewController, HUDRenderer, KeyboardObserver {
    
    //MARK: - Outlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var txfFirstName: UITextField!
    
    @IBOutlet weak var txfLastName: UITextField!
    
    @IBOutlet weak var txfMobile: UITextField!
    
    @IBOutlet weak var txfEmail: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //Conforming to Keyboard observer protocol
    var container: UIView{
        return scrollView
    }
    
    var presenter: AddOrEditContactPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications(shouldRegister: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.registerForKeyboardNotifications(shouldRegister: false)
    }
    
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        presenter?.addOrUpdateContact(firstName:txfFirstName.text, lastName:txfLastName.text, email:txfEmail.text, phone:txfMobile.text)
    }
    
    
}


extension AddOrEditContactView : AddOrEditContactViewProtocol {
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func hideLoading() {
        self.hideActivityIndicator()
    }
    
    
    
    func displayContactDetails(_ contact: ContactModel) {
        txfEmail.text = contact.email
        txfMobile.text = contact.phoneNumber
        txfFirstName.text = contact.firstName
        txfLastName.text = contact.lastName
    }
    
    func setProfilePic(_ imageData: Data) {
        profilePicImageView.image = UIImage(data: imageData)
    }
    
    func showValidationErrorMessage() {
        self.showAlert(message: "Please enter valid data.")
    }
    
    func onError() {
        self.showAlert(message: "Could not save the contact. Please try again.")
    }
    
    func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}

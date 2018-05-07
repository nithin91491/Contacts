//
//  ContactsListView.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import UIKit

class ContactsListView: UIViewController, HUDRenderer {
    
    @IBOutlet weak var tableView:UITableView!
    var presenter: ContactListPresenterProtocol?
    
    var contacts = [[ContactModel]]()
    let contactCellReuseId = "ContactListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup tableview
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        //Load initial data
        presenter?.viewDidLoad()
    }
    
    
    @IBAction func addNewContact(_ sender: UIBarButtonItem) {
        presenter?.addNewContact()
    }
    
}

extension ContactsListView:ContactListViewProtocol, ContactListRefreshDelegate{
    
    func showContacts(_ contacts: [[ContactModel]]) {
        self.contacts = contacts
        tableView.reloadData()
    }
    
    func onError() {
        self.showAlert(message: "An error occured. Please try again later")
    }
    
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func hideLoading() {
        self.hideActivityIndicator()
    }
    
    func refreshData() {
        presenter?.viewDidLoad()
    }
}

extension ContactsListView : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellReuseId , for: indexPath) as! ContactListTableViewCell
        
        let contact = contacts[indexPath.section][indexPath.row]
        cell.setContact(contact)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        if let firstNameChar = contacts[section].first?.firstName.first {
            label.text = "  " + "\(firstNameChar)"
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactId = contacts[indexPath.section][indexPath.row].id
        presenter?.showContactDetail(for: contactId)
    }
}

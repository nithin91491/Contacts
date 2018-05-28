//
//  ContactDetailsDataManager.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation

class ContactDetailsDataManager: ContactDetailsDataManagerInputProtocol {

    var dataManagerOutput: ContactDetailsDataManagerOutputProtocol?
    
    var requestManager:RequestManagerProtocol {
        return RequestManager()
    }
 
    func retreiveContactDetails(_ contactId: Int) {
        
        requestManager.request(.get, apiPath: .getContactDetails(id: contactId), httpBody: nil) { (response) in
            switch response {
            case .success(let json):
                
                do{
                    let contactDetails:ContactModel = try JSONDecoder.decode(json: json)
                    self.dataManagerOutput?.didRetriveContactDetails(contactDetails)
                } catch{
                    print(error.localizedDescription)
                }
                
                
            case .failure(_):
                self.dataManagerOutput?.onError()
            }
        }
    }
    
    func downloadProfilePic(url:String){
        let profilePicUrl = BaseURL.url + url
        
        Downloader.shared.downloadIfNotCached(profilePicUrl) { (imageData) in
            self.dataManagerOutput?.didDownloadProfilePic(imageData!)
        }
    }
    
    func toggleFavourite(contactId:Int, favourite:Bool) {
        
        let body = ["favorite":favourite].jsonString()
        
        requestManager.request(.put, apiPath: .updateContact(id: contactId), httpBody: body) { (response) in
            switch response {
            case .success(_):
                self.dataManagerOutput?.didToggleFavourite()
            case .failure(_):
                self.dataManagerOutput?.onError()
            }
        }
    }
}

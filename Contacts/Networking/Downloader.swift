//
//  Downloader.swift
//  Contacts
//
//  Created by Nithin on 04/05/18.
//  Copyright © 2018 Nithin. All rights reserved.
//

import Foundation


class Wrapper<T> {
    let p:T
    init(_ p:T){self.p = p}
}

typealias MyDownloaderCompletion = (Data?) -> ()

class Downloader: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    static let shared = Downloader(configuration: .default)
    
    private let config : URLSessionConfiguration
    
    private lazy var session : Foundation.URLSession = {
        let queue = OperationQueue.main
        return Foundation.URLSession(configuration:self.config,
                                     delegate:self, delegateQueue:queue)
    }()
    
    private var cache:NSCache<AnyObject, AnyObject>
    
    private init(configuration config:URLSessionConfiguration) {
        self.config = config
        self.cache = NSCache()
        cache.countLimit = 100
        super.init()
    }
    
    @discardableResult
    func downloadIfNotCached(_ url:String, completionHandler ch : MyDownloaderCompletion)
        -> URLSessionTask? {
            
            //Check if the image is cached, If so, return it immediately
            if let cachedImage = self.cache.object(forKey: url as AnyObject), let imageData = cachedImage as? Data {
                ch(imageData)
//                print("cached")
                return nil
            }
            
            //If not, download the image from network
            if let url = URL(string:url){
                let req = NSMutableURLRequest(url:url)
                URLProtocol.setProperty(Wrapper(ch), forKey: "ch", in: req)
                let task = self.session.downloadTask(with: req as URLRequest)
                task.resume()
                return task
            }
            return nil
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let req = downloadTask.originalRequest!
        let ch : AnyObject =
            URLProtocol.property(forKey: "ch", in:req)! as AnyObject
        let response = downloadTask.response as! HTTPURLResponse
        let stat = response.statusCode
        var url : URL! = nil
        if stat == 200 {
            url = location
        }
        
        let ch2 = (ch as! Wrapper).p as MyDownloaderCompletion
        
        let imageData = try? Data(contentsOf: url)
        //Save the downloaded image in the cache and return the image.
        if let imagedata = imageData  {
            DispatchQueue.main.async(execute: {
                ch2(imagedata)
//                print("downloaded")
                self.cache.setObject(imagedata as AnyObject, forKey:req.url!.absoluteString as AnyObject)
            })
        } else {
            DispatchQueue.main.async(execute: {
                ch2(nil)
            })
        }
    }
    
    func cancelAllTasks() {
        self.session.invalidateAndCancel()
    }
}


//
//  ApiManager.swift
//  CdCenturyLink
//
//  Created by serge kone Dossongui on 5/13/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: SessionManager {
    
    static var shared: APIManager = APIManager()
    
    static let requestURL = "http://asset-api-master.centurylink.digital/asset/stocks"
    
    func getLocalHomeStocks(completion: @escaping ([Item]?, Error?) -> ()) {
        
        //use data from local disk
        
        if let data = UserDefaults.standard.object(forKey: "homeStocks_items") as? Data {
            let itemDictionaries = NSKeyedUnarchiver.unarchiveObject(with: data) as! [[String: Any]]
            let items = itemDictionaries.flatMap({ (dictionary) -> Item in
                Item(dictionary: dictionary)!
            })
            
            completion(items, nil)
            return
        }
        
        
    }
    
    
    func getHomeStocks(completion: @escaping ([Item]?, Error?) -> ()) {
        
        // This uses fresh item
        
        request(URL(string: APIManager.requestURL)!, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    completion(nil, error)
                    return
                case .success:
                    guard let itemDictionaries = response.result.value as? [[String: Any]] else {
                        
                        debugPrint("Failed to parse items")
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to parse items"])
                        completion(nil, error)
                        return
                    }
                    
                    let data = NSKeyedArchiver.archivedData(withRootObject: itemDictionaries)
                    UserDefaults.standard.set(data, forKey: "homeStocks_items")
                    UserDefaults.standard.synchronize()
                    
                    let items = itemDictionaries.compactMap({ (dictionary) -> Item in
                        Item(dictionary: dictionary)!
                    })
                    completion(items, nil)
                }
        }
    }
    
    
}

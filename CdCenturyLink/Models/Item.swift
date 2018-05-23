//
//  Stocks.swift
//  CdCenturyLink
//
//  Created by serge kone Dossongui on 5/13/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import Foundation

class Item {
    
    var id: String!
    var techId: String!
    var assetTag: String!
    var assetStatus: String!
    var verification: String!
    var assetStatusHistory: String!
    
    
    init?(dictionary: [String: Any]) {
        
  
        guard  let id  = dictionary["id"] as? String,
            let techId  = dictionary["techId"] as? String,
            let assetTag  = dictionary["assetTag"] as? String,
            let assetStatus  = dictionary["assetStatus"] as? String,
            let _  = dictionary["verification"] as? String,
            let assetStatusHistories = dictionary["assetStatusHistories"] as? [[String:Any]]
            
            else {
                return nil
        }
        
        guard  let assetStatusHistory  = assetStatusHistories.first?["assetStatus"] as? String else {
            return nil
        }
        

        self.id = id
        self.techId = techId
        self.assetTag = assetTag
        self.assetStatus = assetStatus
        self.assetStatusHistory = assetStatusHistory as! String
    }
}

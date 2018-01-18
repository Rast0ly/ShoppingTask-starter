//
//  GenericTriggerOffer.swift
//  ShoppingTask
//
//  Created by Andrew Muncey on 18/01/2018.
//  Copyright © 2018 University of Chester. All rights reserved.
//

class GenericTriggerOffer : TriggerOffer {
    var triggerProductIds: Set<Int>
    
    var discountableProductIds: Set<Int>
    
    var name: String
    
    init?(name: String, triggerProductIds: Set<Int>, discountableProductIds: Set<Int>){
        guard triggerProductIds.count > 0 && discountableProductIds.count > 0 else {
            return nil
        }
        
        self.name = name
        self.triggerProductIds = triggerProductIds
        self.discountableProductIds = discountableProductIds
    }

}

//
//  Item.swift
//  Todoey
//
//  Created by Piotr Cybulski on 06/10/2019.
//  Copyright © 2019 Piotr Cybulski. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable{
    
    var title : String
    var done : Bool
    
    init(title : String, done : Bool = false) {
        self.title = title
        self.done = done
    }
    
}

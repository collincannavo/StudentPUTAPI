//
//  Student.swift
//  StudentPUTAPI
//
//  Created by Collin Cannavo on 6/14/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation

class Student {

    static fileprivate let nameKey = "nombre"
    
    let name: String
    
    init(name: String) {
     
        self.name = name
        
    }
}

// JSON Stuff

extension Student {
    
    convenience init?(dictionary: [String:String]) {
        guard let name = dictionary[Student.nameKey]
            else { return nil }
        
        self.init(name: name)
        
    }
    
    var dictionaryRepresentation: [String: String] {
        return [Student.nameKey: name]
    }
    
    var jsonData: Data? {
        
        let data = try? JSONSerialization.data(withJSONObject: self.dictionaryRepresentation, options: .prettyPrinted)
        return data
    }

}

















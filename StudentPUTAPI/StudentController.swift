//
//  StudentController.swift
//  StudentPUTAPI
//
//  Created by Collin Cannavo on 6/14/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

class StudentController {

    static let baseURL = URL(string: "https://swiftyfireheads.firebaseio.com/students/")

    // Create
    
    static func postStudent(with name: String, completion: @escaping (Bool) -> Void) {
        
       let student = Student(name: name)
        
        guard let baseURL = baseURL else { return }
        
        let url = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        
        request.httpBody = student.jsonData
        
        request.httpMethod = "POST"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8)
                else { completion(false); return }
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else if responseDataString.contains("error") {
                print("Data Response String found error")
                completion(false)
                return
            } else {
                print("Successfully saved student in FireBase")
                completion(true)
        }
    }
        dataTask.resume()
}
    
    // Read
    
    static func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        // create URL
        
        guard let unwrappedURL = baseURL else { completion([]); return }
        
        let url = unwrappedURL.appendingPathExtension("json")
        
        // Create request
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        // Create dataTask
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data,
            let serializedDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String: String]]
                else { completion([]); return }
            
            // Create Student
           
            let studentsArray = serializedDictionary.flatMap( { Student(dictionary: $0.value) } )
            
            completion(studentsArray)
        }
        
        dataTask.resume()
    }
}



















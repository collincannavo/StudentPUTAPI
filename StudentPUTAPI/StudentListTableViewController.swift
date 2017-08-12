//
//  StudentListTableViewController.swift
//  StudentPUTAPI
//
//  Created by Collin Cannavo on 6/14/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!

    var students = [Student]() {
        didSet {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentController.fetchStudents { (students) in
            
            self.students = students
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        nameTextField.resignFirstResponder()
        
        guard let name = nameTextField.text,
            name != ""
            else { return }
        
        StudentController.postStudent(with: name) { (success) in
            
            if success {
                StudentController.fetchStudents(completion: { (students) in
                    
                    self.students = students
                
                })
            }
        }
            nameTextField.text = ""
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name
        
        

        return cell
    }
 

}

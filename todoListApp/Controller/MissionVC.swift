//
//  MissionVC.swift
//  todoListApp
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class MissionVC: UIViewController {
    
    @IBOutlet weak var missionTitleLbl: UILabel!
    @IBOutlet weak var missionTitleTextField: UITextField!
    @IBOutlet weak var missionNotesTextView: UITextView!
    @IBOutlet weak var missionDueDatePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addMissionButtonPressed(_ sender: Any) {
        if missionTitleTextField.text != "" || missionNotesTextView.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let strDate = dateFormatter.string(from: missionDueDatePicker.date)
            DataService.instance.addNewMission(withTitle: missionTitleTextField.text!, notes: missionNotesTextView.text, andDueDate: strDate)
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Empty field", message: "Please enter your new mission details in the fields above", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

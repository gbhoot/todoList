//
//  MissionCell.swift
//  todoListApp
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class MissionCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var missionTitleLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var missionNotesLbl: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Functions
    func configureCell(title: String, dueDate: String, notes: String, completed: Bool) {
        missionTitleLbl.text = title
        dueDateLbl.text = dueDate
        missionNotesLbl.text = notes
        if !completed {
            checkMarkButton.isHidden = true
        }
    }
    
    func missionCompleted() {
        checkMarkButton.isHidden = false
    }
}

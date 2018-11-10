//
//  UpcomingChoreTableViewCell.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/31/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit
import Foundation

class UpcomingChoreTableViewCell: UITableViewCell {
    private var upcomingChore: UpcomingChore? = nil
    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var choreDueDateLabel: UILabel!
    
    //MARK: Outlets

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpcomingChore(_ chore: UpcomingChore) {
        upcomingChore = chore
        choreNameLabel.text = upcomingChore?.name ?? ""
        guard let dueDate = upcomingChore?.dueDateToDate() else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM dd"
        choreDueDateLabel.text = formatter.string(from: dueDate)
    }
    
    func getUpcomingChore() -> UpcomingChore {
        return upcomingChore!
    }

}

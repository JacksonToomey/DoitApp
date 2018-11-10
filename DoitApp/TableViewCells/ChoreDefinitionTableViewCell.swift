//
//  ChoreDefinitionTableViewCell.swift
//  DoitApp
//
//  Created by Jackson Toomey on 11/3/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit

class ChoreDefinitionTableViewCell: UITableViewCell {
    var choreDefinition: ChoreDefinition?
    
    @IBOutlet weak var choreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setChoreDefinition(_ chore: ChoreDefinition) {
        choreDefinition = chore
        choreNameLabel.text = choreDefinition?.name ?? ""
    }
}

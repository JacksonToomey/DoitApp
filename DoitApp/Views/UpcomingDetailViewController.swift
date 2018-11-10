//
//  UpcomingDetailViewController.swift
//  DoitApp
//
//  Created by Jackson Toomey on 11/2/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit
import Foundation

class UpcomingDetailViewController: UIViewController {
    private var upcomingChore: UpcomingChore?
    
    //MARK: Outlets
    @IBOutlet weak var choreNameLabel: UILabel!
    @IBOutlet weak var choreDetailTextView: UITextView!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choreNameLabel.text = upcomingChore?.name
        choreDetailTextView.text = upcomingChore?.details
        guard let dueDate = upcomingChore?.dueDateToDate() else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM dd"
        dueDateLabel.text = formatter.string(from: dueDate)
    }
    
    func setUpcomingChore(_ chore: UpcomingChore) {
        upcomingChore = chore
    }
    
    // MARK: - Actions
    @IBAction func onDoitClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

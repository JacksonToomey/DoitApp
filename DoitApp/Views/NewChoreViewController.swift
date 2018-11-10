//
//  NewChoreViewController.swift
//  DoitApp
//
//  Created by Jackson Toomey on 11/3/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit

class NewChoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Actions
    @IBAction func onCancelPress(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveNewChoreClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

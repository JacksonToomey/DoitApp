//
//  CurrentUser.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/30/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit

class CurrentUser {
    static let shared = CurrentUser()
    var token: String
    
    private init() {
        token = ""
    }

}

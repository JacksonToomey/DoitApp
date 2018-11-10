//
//  UpcomingTableViewController.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/30/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit

class UpcomingTableViewController: UITableViewController {
    var upcomingChores = [UpcomingChore]()
    
    //MARK: Outlets
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        ApiClient.getUpcomingChores({upcomingChores in
            self.upcomingChores = upcomingChores
            self.loadingIndicatorView.stopAnimating()
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return upcomingChores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "UpcomingChoreCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UpcomingChoreTableViewCell else {
            fatalError("?")
        }
        let upcomingChore = upcomingChores[indexPath.row]
        cell.setUpcomingChore(upcomingChore)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let upcomingChoreDetailViewController = segue.destination as? UpcomingDetailViewController else {
            fatalError("?")
        }
        guard let selectedChoreCell = sender as? UpcomingChoreTableViewCell else {
            fatalError("?")
        }
        upcomingChoreDetailViewController.setUpcomingChore(selectedChoreCell.getUpcomingChore())
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let doitAction = UITableViewRowAction(
            style: .normal,
            title: "Do It",
            handler: {(action, indexPath) in
                self.upcomingChores.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        )
        return [doitAction]
    }
}

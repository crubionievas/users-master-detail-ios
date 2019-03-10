//
//  MasterViewController.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 07/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import UIKit
import AlamofireImage

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    fileprivate lazy var repository = UsersRepository(delegate: self)
    private var users = [User]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        showProgress(true)
        repository.getUsers(forResults: 100)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let user = users[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = user
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell

        let user = users[indexPath.row]
        
        cell.userName.text = user.name?.getFullName()
        
        // Download thumbnail
        if let imageUrl = user.picture?.thumbnail {
            if let url = URL(string: imageUrl) {
                cell.userImage.af_setImage(withURL: url)
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension MasterViewController: UsersRepositoryDelegate {
    func usersFailed(error: APIError?, forRequestedNumber: Int) {
        showProgress(false)
    }
    
    func usersReceived() {
        showProgress(false)
        
        users = repository.users
        
        self.tableView?.reloadData()
    }
}



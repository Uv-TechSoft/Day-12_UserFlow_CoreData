//
//  UserlistViewController.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 24/11/21.
//

import UIKit

class UserlistViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    var userArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userArray = DatabaseHelper.shareInstance.getallUsers()
        userTableView.register(UINib(nibName: "userlistCell", bundle: nil), forCellReuseIdentifier: "userlistCell")
    
    }

}

extension UserlistViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userTableView.dequeueReusableCell(withIdentifier: "userlistCell") as? userlistCell else
        {
            return UITableViewCell()
        }
        cell.userConfig(user: userArray[indexPath.row])
        return cell
    }
}

extension UserlistViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            DatabaseHelper.shareInstance.deleteUser(user:userArray[indexPath.row])
            userArray.remove(at: indexPath.row)
            userTableView.reloadData()
        }
    }
}

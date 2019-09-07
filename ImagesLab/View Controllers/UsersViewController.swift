//
//  UsersViewController.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    
    var users = [InfoWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
    }
    private func loadData() {
        DispatchQueue.main.async {
            Users.getUsers { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let usersFromData):
                    self.users = usersFromData
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        usersTableView.dataSource = self
        usersTableView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController, let indexPath = usersTableView.indexPathForSelectedRow else {return}
        destination.randomUser = users[indexPath.row]
    }

}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let randomUserCell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UsersTableViewCell else {return UITableViewCell()}
        let user = users[indexPath.row]
        randomUserCell.nameLabel.text = user.getFullNameUppercased()
        randomUserCell.ageLabel.text = "Age: \(user.dob.age)"
        randomUserCell.cellPhoneLabel.text = user.cell
        ImageHelper.shared.fetchImage(urlString: user.picture.thumbnail) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userImageFromUrl):
                    randomUserCell.userImage.image = userImageFromUrl
                }
            }
        }
        return randomUserCell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

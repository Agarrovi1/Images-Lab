//
//  UserDetailViewController.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var userLargeImage: UIImageView!
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var randomUser: InfoWrapper?
    
    private func loadUserPic() {
        guard let randomUser = randomUser else {return}
        ImageHelper.shared.fetchImage(urlString: randomUser.picture.large) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let largeImage):
                    self.userLargeImage.image = largeImage
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let randomUser = randomUser else {return}
        loadUserPic()
        nameLabel.text = randomUser.getFullNameUppercased()
        ageLabel.text = "Age: \(randomUser.dob.age)"
        phoneNumLabel.text = "Phone: \(randomUser.phone)\nCell: \(randomUser.cell)"
        locationLabel.text = randomUser.getFullAddress()
    }

}

//
//  PokeCardTableViewCell.swift
//  ImagesLab
//
//  Created by Angela Garrovillas on 9/6/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class PokeCardTableViewCell: UITableViewCell {
    @IBOutlet weak var pokeCardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

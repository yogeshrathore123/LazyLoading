//
//  UserTableViewCell.swift
//  LazyLoading
//
//  Created by Yogesh Rathore on 17/04/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

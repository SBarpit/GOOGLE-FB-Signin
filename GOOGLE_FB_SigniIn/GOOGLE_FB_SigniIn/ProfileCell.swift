//
//  ProfileCell.swift
//  GOOGLE_FB_SigniIn
//
//  Created by Appinventiv Mac on 27/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileIV.layer.cornerRadius = self.profileIV.bounds.width/2
        self.profileIV.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

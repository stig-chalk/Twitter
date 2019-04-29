//
//  tweetsTableViewCell.swift
//  Twitter
//
//  Created by Yuhui Chen on 4/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class tweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

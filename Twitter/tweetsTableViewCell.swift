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
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweetId: Int = -1
    var fav: Bool = false

    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBefav = !fav
        if (toBefav) {
            TwitterAPICaller.client?.favoriateTweet(id: tweetId, success: {
                self.setFav(true)
            }, failure: { (Error) in
                print("favorite did not succeed: \(Error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriateTweet(id: tweetId, success: {
                self.setFav(false)
            }, failure: { (Error) in
                print("unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(id: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (Error) in
            print("retweet did not succedd: \(Error)")
        })
        
    }
    
    func setFav(_ isFav: Bool) {
        fav = isFav
        if (fav) {
            favButton.setImage(UIImage(named: "fav-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "fav-icon-grey"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-grey"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

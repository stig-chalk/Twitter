//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Yuhui Chen on 4/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var userArray = [NSDictionary]()
    var tweetNum: Int!
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }

    @objc func loadTweets() {
        tweetNum = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count":tweetNum]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: params, success: { (tweets:[NSDictionary]) in
            self.userArray.removeAll()
            for tweet in tweets {
                self.userArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("1st, oops")
        })
        
    }
    // MARK: - Table view data source
    
    func loadMoreTweets() {
        tweetNum += 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count":tweetNum]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: params, success: { (tweets:[NSDictionary]) in
            self.userArray.removeAll()
            for tweet in tweets {
                self.userArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("2nd, oops")
        })
    }

    @IBAction func logoutPressed(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "loggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArray.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == userArray.count {
            loadMoreTweets()
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetsCell", for: indexPath) as! tweetsTableViewCell
        let user = userArray[indexPath.row]["user"] as! NSDictionary
        cell.userName.text = user["name"] as? String
        cell.tweetContent.text = self.userArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.userImage.image = UIImage(data: imageData)
        }
        
        cell.setFav(userArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = userArray[indexPath.row]["id"] as! Int
        cell.setRetweet(userArray[indexPath.row]["retweeted"] as! Bool)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

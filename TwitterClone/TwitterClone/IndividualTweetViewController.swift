//
//  IndividualTweetViewController.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/6/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import Foundation
import UIKit

class IndividualTweetViewController : UIViewController {


  
  @IBOutlet weak var secondTableView: UITableView!
  
    var tweets = [Tweet]()
  var originalUsername : String?
  var originalTweet : String?
  override func viewDidLoad() {
    super.viewDidLoad()
    println(tweets.count)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
//MARK: UITableViewDataSource2
extension IndividualTweetViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
    //return 1
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IndividualTweet", forIndexPath: indexPath) as! DetailTweetCell
//    cell.detailUsernameLabel.text = tweets[indexPath.row].originalUser
//    cell.detailTweetLabel.text = tweets[indexPath.row].originalTweet
    cell.detailUsernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
    
    let tweet = tweets[indexPath.row]
    
    if let originalUsername = originalUsername {
      cell.detailUsernameLabel.text = tweet.originalUsername
    } else {
      cell.detailUsernameLabel.text = tweet.username
    }
    if let originalTweet = originalTweet {
      cell.detailTweetLabel.text = tweet.originalTweet
    } else {
      cell.detailTweetLabel.text = tweet.text
    }
    
    return cell
  }
}
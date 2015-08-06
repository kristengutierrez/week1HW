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
  
  var toPass : String?
  var tweets = [Tweet]()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
//MARK: UITableViewDataSource2
extension IndividualTweetViewController: UITableViewDataSource {
  func secondTableView(secondTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //return self.tweets.count
  }
  func secondTableView(secondTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = secondTableView.dequeueReusableCellWithIdentifier("IndividualTweet", forIndexPath: indexPath) as! DetailTweetCell
    cell.detailUsernameLabel.text = tweets[indexPath.row].originalUser
    cell.detailTweetLabel.text = tweets[indexPath.row].originalTweet
    //cell.usernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
    return cell
  }
}
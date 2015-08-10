//
//  ThirdViewController.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/9/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import UIKit


class ThirdViewController : UIViewController {
  
  @IBOutlet weak var thirdTableView: UITableView!
  
  func button (NSObject){
    self.performSegueWithIdentifier("secondSegue", sender: self)
  }
  
  var tweets = [Tweet]()
  let imageQueue = NSOperationQueue()
  override func viewDidLoad() {
    super.viewDidLoad()

    thirdTableView.estimatedRowHeight = 70
    thirdTableView.rowHeight = UITableViewAutomaticDimension
    
    thirdTableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineTweetCell")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
//MARK: UITableViewDataSource3
extension ThirdViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TimelineTweetCell", forIndexPath: indexPath) as! TweetCell
    cell.usernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.tag++
    let tag = cell.tag
    
    let tweet = tweets[indexPath.row]
    if let profileImage = tweet.profileImage {
      cell.profileImageView.setBackgroundImage(profileImage, forState: UIControlState.Normal)
    } else {
      imageQueue.addOperationWithBlock({ () -> Void in
        
        if let imageURL = NSURL(string: tweet.profileImageURL!),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            var size: CGSize
            switch UIScreen.mainScreen().scale {
            case 1:
              size = CGSize(width: 160, height: 160)
            case 2:
              size = CGSize(width: 240, height: 240)
            default:
              size =  CGSize(width: 80, height: 80)
            }
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets[indexPath.row].profileImage = image
              self.tweets[indexPath.row] = tweet
              if cell.tag == tag {
                cell.profileImageView.setBackgroundImage(image, forState: UIControlState.Normal)
              }
            })
            
        }
        
      })
    }
    
    if let originalUsername = tweet.originalUsername {
      cell.usernameLabel.text = tweet.originalUsername
    } else if let originalQuotedUsername = tweet.originalQuotedUsername {
      cell.usernameLabel.text = tweet.originalQuotedUsername
    } else {
      cell.usernameLabel.text = tweet.username
    }
    
    
    if let originalTweet = tweet.originalTweet {
      cell.tweetLabel.text = tweet.originalTweet
    } else if let originalQuotedTweet = tweet.originalQuotedTweet {
      cell.tweetLabel.text = tweet.originalQuotedTweet
    } else {
      cell.tweetLabel.text = tweet.text
      println(tweet.text)
    }
    

    
    
    
    return cell
  }
  
}
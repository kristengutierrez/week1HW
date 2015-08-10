//
//  ViewController.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  
  var tweets = [Tweet]()
  let imageQueue = NSOperationQueue()
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //self.navigationController?.navigationBarHidden = true
    
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineTweetCell")
    tableView.estimatedRowHeight = 70
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.dataSource = self
    tableView.delegate = self
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
      }
      if let account = account {
        TwitterService.sharedService.account = account
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.activityIndicator.startAnimating()
        })
        TwitterService.tweetsFromHomeTimeline({ (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            //Do on main queue because you might have multiple things trying to change the array
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
              self.tweets = tweets
              self.activityIndicator.stopAnimating()
              self.tableView.reloadData()
            }
            
          }
        })
      }
    }
    
    
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabels", name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TimelineTweetCell", forIndexPath: indexPath) as! TweetCell
    
    cell.tag++
    let tag = cell.tag
    cell.usernameLabel.text = tweets[indexPath.row].username
    cell.tweetLabel.text = tweets[indexPath.row].text
    cell.usernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
    var tweet = tweets[indexPath.row]
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
              tweet.profileImage = image
              self.tweets[indexPath.row] = tweet
              if cell.tag == tag {
                cell.profileImageView.setBackgroundImage(image, forState: UIControlState.Normal)
              }
            })
            
        }
        
      })
    }
    
    
    return cell
  }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "cellSegue" {
      var itvc = segue.destinationViewController as! IndividualTweetViewController;
      var selectedIndexPath = self.tableView.indexPathForSelectedRow()
      var selectedRow: Tweet = self.tweets[selectedIndexPath!.row]
      println(selectedRow.originalTweet)
      itvc.tweets.append(selectedRow)
      
    }
  }
  
  
}

//MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("cellSegue", sender: self)
  }
}








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
  
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    //self.navigationController?.navigationBarHidden = true

    tableView.estimatedRowHeight = 70
    tableView.rowHeight = UITableViewAutomaticDimension
    
    
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
//    if let filepath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json")
//    {
//      if let data = NSData(contentsOfFile: filepath) {
//        if let tweets = TweetJSONParser.tweetsFromJSONData(data) {
//          self.tweets = tweets
//          println(self.tweets)
//        }
//      }
//    }
    // Do any additional setup after loading the view, typically from a nib.
    
    
  
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
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TweetCell
   // cell.textLabel?.text = tweets[indexPath.row].text
    cell.usernameLabel.text = tweets[indexPath.row].username
    cell.tweetLabel.text = tweets[indexPath.row].text
    cell.usernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
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


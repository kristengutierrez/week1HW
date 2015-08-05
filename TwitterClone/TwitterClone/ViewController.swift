//
//  ViewController.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
      }
      if let account = account {
        TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            //Do on main queue because you might have multiple things trying to change the array
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
              self.tweets = tweets
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
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = tweets[indexPath.row].text
    return cell
  }
  
}
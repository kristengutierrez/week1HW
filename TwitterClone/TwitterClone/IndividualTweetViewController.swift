//
//  IndividualTweetViewController.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/6/15.
//  Copyright (c) 2015 koz. All rights reserved.
//


import UIKit

class IndividualTweetViewController : UIViewController {


  
  @IBOutlet weak var secondTableView: UITableView!

    var tweets = [Tweet]()
  let imageQueue = NSOperationQueue()
  override func viewDidLoad() {
    super.viewDidLoad()
    secondTableView.estimatedRowHeight = 70
    secondTableView.rowHeight = UITableViewAutomaticDimension
    secondTableView.dataSource = self
//    secondTableView.delegate = self
    secondTableView.registerNib(UINib(nibName: "DetailTweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "IndividualTweet")
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
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IndividualTweet", forIndexPath: indexPath) as! DetailTweetCell
    cell.detailUsername.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.tag++
    let tag = cell.tag
    
    let tweet = tweets[indexPath.row]
    if let profileImage = tweet.profileImage {
      cell.detailImageButton.setBackgroundImage(profileImage, forState: UIControlState.Normal)
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
                cell.detailImageButton.setBackgroundImage(image, forState: UIControlState.Normal)
              }
            })
            
        }
        
      })
    }

    
    if let originalUsername = tweet.originalUsername {
      cell.detailUsername.text = tweet.originalUsername
    } else if let originalQuotedUsername = tweet.originalQuotedUsername {
      cell.detailUsername.text = tweet.originalQuotedUsername
    } else {
      cell.detailUsername.text = tweet.username
    }
    
    
    if let originalTweet = tweet.originalTweet {
      cell.detailTweet.text = tweet.originalTweet
    } else if let originalQuotedTweet = tweet.originalQuotedTweet {
      cell.detailTweet.text = tweet.originalQuotedTweet
    } else {
      cell.detailTweet.text = tweet.text
    }
    

    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "secondSegue" {
      var itvc = segue.destinationViewController as! ThirdViewController;
      var selectedIndexPath = self.secondTableView.indexPathForSelectedRow()
      var selectedRow: Tweet = self.tweets[selectedIndexPath!.row]
      itvc.tweets.append(selectedRow)
      
    }
  }
  
}


//MARK: UITableViewDelegate2
extension IndividualTweetViewController : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       self.performSegueWithIdentifier("secondSegue", sender: self)
  }
}

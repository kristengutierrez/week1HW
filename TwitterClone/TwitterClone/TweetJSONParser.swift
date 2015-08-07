//
//  TweetJSONParser.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//


import UIKit


class TweetJSONParser {
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
      var tweets = [Tweet]()
      for tweetObject in rootObject {
        //        println(tweetObject)
        if let text = tweetObject["text"] as? String,
          id = tweetObject["id_str"] as? String,
          userInfo = tweetObject["user"] as? [String : AnyObject],
          username = userInfo["name"] as? String,
          profileImageURL = userInfo["profile_image_url"] as? String {
            
            var tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL, originalTweet: nil, originalUsername: nil, profileImage: nil, originalQuotedTweet: nil, originalQuotedUsername: nil)
            
            if let imageURL = NSURL(string: profileImageURL),
            imageData = NSData(contentsOfURL: imageURL),
            image = UIImage(data: imageData) {
              tweet.profileImage = image
            }
            
            if let quotedTweet = tweetObject["quoted_status"] as? [String : AnyObject],
            originalQuotedTweet = quotedTweet["text"] as? String,
            originalQuotedUserInfo = quotedTweet["user"] as? [String : AnyObject],
              originalQuotedUsername = originalQuotedUserInfo["name"] as? String {
                let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL, originalTweet: nil, originalUsername: nil, profileImage: nil, originalQuotedTweet: originalQuotedTweet, originalQuotedUsername: originalQuotedUsername)
                tweets.append(tweet)
                
            } else {
            if let retweet = tweetObject["retweeted_status"] as? [String : AnyObject],
              originalTweet = retweet["text"] as? String,
              originalUserInfo = retweet["user"] as? [String : AnyObject],
              originalUsername = originalUserInfo["name"] as? String {
                
                let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL, originalTweet: originalTweet, originalUsername: originalUsername, profileImage: nil, originalQuotedTweet: nil, originalQuotedUsername: nil)
                 tweets.append(tweet)
            } else {
              tweets.append(tweet)
            }
            }
        }
      }
      return tweets
    }
    return nil
  }
}
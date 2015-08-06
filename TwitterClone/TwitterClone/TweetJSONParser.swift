//
//  TweetJSONParser.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import Foundation


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
            
            let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL, originalTweet: nil, originalUsername: nil)
            
            if let retweet = tweetObject["retweeted_status"] as? [String : AnyObject],
              originalTweet = retweet["text"] as? String,
              originalUserInfo = retweet["user"] as? [String : AnyObject],
              originalUsername = originalUserInfo["name"] as? String {
                
                let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL, originalTweet: originalTweet, originalUsername: originalUsername)
                 tweets.append(tweet)
                
            } else {
              tweets.append(tweet)
            }
           
        }
      }
      return tweets
    }
    return nil
  }
}
//
//  TwitterService.swift
//  TwitterClone
//
//  Created by Kristen Kozmary on 8/4/15.
//  Copyright (c) 2015 koz. All rights reserved.
//

import Foundation
import Accounts
import Social


class TwitterService {
  class func tweetsFromHomeTimeline
}



























//class TwitterService {
//  class func tweetsFromHomeTimeline(account : ACAccount, completionHandler : (String?, [Tweet]?) -> (Void)) {
//    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
//    request.account = account
//    request.performRequestWithHandler { (data, response, error) -> Void in
//      if let error = error {
//        completionHandler("could not connect to the server", nil)
//      } else {
//        println(response.statusCode)
//        switch response.statusCode {
//        case 200...299:
//          let tweets = TweetJSONParser.tweetsFromJSONData(data)
//          completionHandler(nil,tweets)
//        case 400...499:
//          completionHandler("this is our fault", nil)
//        case 500...599:
//          completionHandler("this is the server's fault", nil)
//        default:
//          completionHandler("error occurred", nil)
//        }
//      }
//    }
//  }
//}
//
//  AppDelegate.swift
//  GATest
//
//  Created by vincentyen on 4/29/15.
//  Copyright (c) 2015 Fun Anima Co., Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var okToWait = false
    var dispatchHandler:((result: GAIDispatchResult) -> Void)?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //GAI.sharedInstance().trackUncaughtExceptions = true
        GAI.sharedInstance().trackerWithName("GATstttt", trackingId: "UA-6893632-9")
        GAI.sharedInstance().dispatchInterval = 20
        GAI.sharedInstance().logger.logLevel = GAILogLevel.Info
        //GAI.sharedInstance().trackerWithTrackingId("UA-6893632-9")
        return true
    }
    
    
    
    func sendHitsInBackground() {
        self.okToWait = true
        weak var weakSelf:AppDelegate! = self
        var backgroundTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            weakSelf!.okToWait = false
        })
        
        
        
        if backgroundTaskId == UIBackgroundTaskInvalid {
            return
        }
        
        self.dispatchHandler = {(result) -> Void in
            if result == GAIDispatchResult.Good && weakSelf!.okToWait == true {
                GAI.sharedInstance().dispatchWithCompletionHandler(weakSelf.dispatchHandler)
            }else{
                UIApplication.sharedApplication().endBackgroundTask(backgroundTaskId)
            }
        }
    }
    
    
    /*
    self.dispatchHandler = ^(GAIDispatchResult result) {
    // If the last dispatch succeeded, and we're still OK to stay in the background then kick off
    // again.
    if (result == kGAIDispatchGood && weakSelf.okToWait ) {
    [[GAI sharedInstance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
    } else {
    [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
    }
    };
    [[GAI sharedInstance] dispatchWithCompletionHandler:self.dispatchHandler];
    }*/


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        self.sendHitsInBackground()
        completionHandler(UIBackgroundFetchResult.NewData)
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.sendHitsInBackground()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


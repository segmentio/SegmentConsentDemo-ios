//
//  AppDelegate.swift
//  SegmentConsentDemo
//
//  Created by Brandon Sneed on 9/16/19.
//  Copyright © 2019 Brandon Sneed. All rights reserved.
//

import UIKit
import Analytics
import OTPublishersSDK
import Segment_Optimizely_X
import OptimizelySDKiOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var consentManager = ConsentManager()
    var optlyManager: OptimizelySDKiOS.OPTLYManager?
    var optlyClient: OptimizelySDKiOS.OPTLYClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // configure segment
        let configuration = SEGAnalyticsConfiguration(writeKey: "YZONHstoxBmfmazuT9SvRMfiSrv5AipQ")
        configuration.trackApplicationLifecycleEvents = true
        configuration.recordScreenViews = true
        configuration.flushAt = 1
        configuration.middlewares = [ConsentMiddleware()]
        
        // setup optimizely
        let optlyLogger = OPTLYLoggerDefault(logLevel: .error)
        let builder = OPTLYManagerBuilder.init { (builder) in
            builder?.projectId = "8135581546"
            builder?.logger = optlyLogger
        }
        optlyManager = OptimizelySDKiOS.OPTLYManager(builder: builder)
        optlyClient = optlyManager?.initialize()
        configuration.use(SEGOptimizelyXIntegrationFactory.instance(withOptimizely: optlyManager))

        SEGAnalytics.setup(with: configuration)
        SEGAnalytics.shared()?.track("test")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


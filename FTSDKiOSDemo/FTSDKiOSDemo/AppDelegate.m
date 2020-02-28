//
//  AppDelegate.m
//  FTSDKiOSDemo
//
//  Created by 胡蕾蕾 on 2019/12/13.
//  Copyright © 2019 hll. All rights reserved.
//

#import "AppDelegate.h"
#import <FTMobileAgent/FTMobileAgent.h>

//配置测试 SDK config
NSString * const ACCESS_KEY_ID  = @"Your App akId";
NSString * const ACCESS_KEY_SECRET  = @"Your App akSecret";
NSString * const ACCESS_SERVER_URL  = @"Your App metricsUrl";
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    FTMobileConfig *config = [[FTMobileConfig alloc]initWithMetricsUrl:ACCESS_SERVER_URL akId:ACCESS_KEY_ID akSecret:ACCESS_KEY_SECRET enableRequestSigning:YES];
    config.enableRequestSigning = YES;
    config.enableLog = YES;
    config.enableAutoTrack = YES;
    config.autoTrackEventType = FTAutoTrackEventTypeAppClick|
    FTAutoTrackEventTypeAppViewScreen;
    [FTMobileAgent startWithConfigOptions:config];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

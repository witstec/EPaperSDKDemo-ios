//
//  AppDelegate.m
//  EPaperBleDemo
//
//  Created by Mocun on 2020/6/1.
//  Copyright © 2020 Mocun. All rights reserved.
//

#import "AppDelegate.h"
#import <EPaperSDK/EPaperBlemanage.h>
#import"EPaperTextController.h"




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
       self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
       EPaperTextController * testvc = [EPaperTextController new];
       UINavigationController * nacc = [[UINavigationController alloc]initWithRootViewController:testvc];
       self.window.rootViewController = nacc;
       [self.window makeKeyAndVisible];
       //实例化
       [[EPaperBlemanage  shareInstance]EPaperinit];
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

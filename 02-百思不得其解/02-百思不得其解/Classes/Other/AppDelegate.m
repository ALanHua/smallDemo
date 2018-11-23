//
//  AppDelegate.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "AppDelegate.h"
#import "YHPTabBarController.h"
#include "YHPPushGuideView.h"
#include "YHPTopWindow.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    1,创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [[UIScreen mainScreen]bounds];
//    2,设置根控制器
    UITabBarController* tabBarController = [[YHPTabBarController alloc]init];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
//    3,显示窗口
    [self.window makeKeyAndVisible];
//   4,添加引导页
    [[YHPPushGuideView guideView]show];
//   5，添加一个window  专门用来处理UIScrolView的回滚
    [YHPTopWindow show];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 发送一个通知
    /*
     *   可以不传
     *   NSMutableDictionary* useInfo = [NSMutableDictionary dictionary];
     *   useInfo[YHPSelectedControllerKey] = viewController;
     *   useInfo[YHPSelectedControllerIndexKey] = @(tabBarController.selectedIndex);
    */
    [[NSNotificationCenter defaultCenter]postNotificationName:YHPTabBarDidSelectedNotification object:nil userInfo:nil];
}


@end

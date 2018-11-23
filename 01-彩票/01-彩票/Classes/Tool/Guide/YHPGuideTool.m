//
//  YHPGuideTool.m
//  01-彩票
//
//  Created by yhp on 16/6/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPGuideTool.h"
#import "YHPTabBarController.h"
#import "YHPNewFretureViewController.h"
#import "YHPSaveTool.h"

#define YHPVersionKey  @"version"

@implementation YHPGuideTool

+(UIViewController*)choseRootViewController
{
    //  判断下与没有最新的版本号，为加载引导界面做准备
    // 获取用户最新的版本号，info.plist
    NSString* curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleInfoDictionaryVersion"];
    // 获取上一次的版本号，先保存我的版本号，选择偏好设置方式，每次进入新特性界面的时候保存
    NSString*oldVersion = [YHPSaveTool objectForKey:YHPVersionKey];
    UIViewController* rootVc = nil;
    if ([curVersion isEqualToString:oldVersion]) {
        //  没有最新的版本号,进入核心界面
        // 创建窗口跟控制器
        // UITabBarController 的view不是懒加载，已创建就加载
        rootVc = [[YHPTabBarController alloc] init];
    }else{// 进入新特性YHPNewFretureViewController界面,保存
        rootVc = [[YHPNewFretureViewController alloc]init];
        [YHPSaveTool setObject:curVersion forKey:YHPVersionKey];
    }
    
    return rootVc;
}
@end

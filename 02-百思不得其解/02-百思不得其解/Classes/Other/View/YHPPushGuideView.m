//
//  YHPPushGuideView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/9/25.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPPushGuideView.h"

@implementation YHPPushGuideView

+(instancetype)guideView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)show
{
    NSString* key = @"CFBundleShortVersionString";
    NSString* currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString* sanboxVersion =  [[NSUserDefaults standardUserDefaults]stringForKey:key];// 沙盒里的软件版本号
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow* window = [[UIApplication sharedApplication]keyWindow];
        YHPPushGuideView* guideView = [YHPPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        // 存储软件版本号
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (IBAction)close:(UIButton *)sender {
    [self removeFromSuperview];
}

@end

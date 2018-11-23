//
//  YHPLoginTool.m
//  02-百思不得其解
//
//  Created by yhp on 2017/3/27.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPLoginTool.h"
#import "YHPLoginRegisterViewController.h"

@implementation YHPLoginTool

+(void)setUid:(NSString*)uid
{
    [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}


+(NSString*)getUid
{
    return [self getUid:NO];
}

+(NSString*)getUid:(BOOL)showLoginController
{
    NSString* uid = [[NSUserDefaults standardUserDefaults]stringForKey:@"uid"];
    if (showLoginController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            YHPLoginRegisterViewController* login = [[YHPLoginRegisterViewController alloc]init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        });
    }

    return uid;
}

@end

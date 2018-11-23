//
//  YHPSaveTool.m
//  01-彩票
//
//  Created by yhp on 16/6/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.


#import "YHPSaveTool.h"

@implementation YHPSaveTool

+(id)objectForKey:(NSString *)defaultName
{
    return  [[NSUserDefaults standardUserDefaults]objectForKey:defaultName];
}

+(void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:defaultName];
}


@end

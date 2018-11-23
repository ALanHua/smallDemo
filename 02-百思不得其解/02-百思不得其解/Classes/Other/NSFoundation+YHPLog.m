//
//  NSDictionary+YHPLog.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (YHPLog)

-(NSString*)descriptionWithLocale:(id)locale
{
    NSMutableString* string = [NSMutableString string];
    // 开头有个{
    [string appendString:@"{\n"];
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@",key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n",obj];
    }];
    // 结束有个{
    [string appendString:@"}"];
    // 去掉最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}

@end


@implementation NSArray (YHPLog)

-(NSString*)descriptionWithLocale:(id)locale
{
    NSMutableString* string = [NSMutableString string];
    // 开头有个[
    [string appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [string appendFormat:@"\t%@,\n", obj];
    }];
    // 结尾有个]
    [string appendString:@"]"];
    // 去掉最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    return string;
}

@end
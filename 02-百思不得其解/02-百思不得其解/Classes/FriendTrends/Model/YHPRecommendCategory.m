//
//  YHPRecommendCategory.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  推荐关注左边的数据模型
//

#import "YHPRecommendCategory.h"
#import <MJExtension.h>

@implementation YHPRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end

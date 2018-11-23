//
//  YHPSettingGroup.m
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSettingGroup.h"

@implementation YHPSettingGroup

+(instancetype)groupWithItem:(NSArray*)item
{
    YHPSettingGroup* group = [[YHPSettingGroup alloc]init];
    
    group.item = item;
    
    return group;
}


@end

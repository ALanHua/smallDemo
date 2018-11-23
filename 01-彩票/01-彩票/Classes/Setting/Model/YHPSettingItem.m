//
//  YHPSettingItem.m
//  01-彩票
//
//  Created by yhp on 16/6/12.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPSettingItem.h"

@implementation YHPSettingItem


+(instancetype)itemWithImage:(UIImage*)image tittle:(NSString*)tittle
{
    YHPSettingItem* item = [[self alloc]init];
    item.image = image;
    item.tittle = tittle;
    
    return item;
}


@end

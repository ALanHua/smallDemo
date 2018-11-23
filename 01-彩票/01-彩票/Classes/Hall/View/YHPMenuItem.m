//
//  YHPMenuItem.m
//  01-彩票
//
//  Created by yhp on 16/5/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPMenuItem.h"

@implementation YHPMenuItem

+(instancetype)itemWithImage:(UIImage*)image tittle:(NSString*)tittle
{
    YHPMenuItem* item = [[self alloc]init];
    item.image  = image;
    item.tittle = tittle;
    
    return item;
}

@end

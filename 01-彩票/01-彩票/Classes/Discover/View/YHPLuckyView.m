//
//  YHPLuckyView.m
//  01-彩票
//
//  Created by yhp on 16/6/2.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPLuckyView.h"




@implementation YHPLuckyView


- (void)drawRect:(CGRect)rect
{
    UIImage* image = [UIImage imageNamed:@"luck_entry_background"];
    
    [image drawInRect:rect];
    
}

@end

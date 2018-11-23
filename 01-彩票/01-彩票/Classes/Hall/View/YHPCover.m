//
//  YHPCover.m
//  01-彩票
//
//  Created by yhp on 16/5/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCover.h"
#import "YHPActiveMenu.h"


@implementation YHPCover

+(void)show
{
   
    // 创建蒙版对象
    YHPCover* cover = [[YHPCover alloc]initWithFrame:YHPScreenBounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.7;

    // 把蒙版对象添加主窗口
    [YHPKeyWindow addSubview:cover];
}

+(void)hide
{
    for (UIView* childView in YHPKeyWindow.subviews) {
        if ([childView isKindOfClass:self]) {
            [childView removeFromSuperview];
        }
        
    }
}
@end

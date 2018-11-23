//
//  YHPTopWindow.m
//  02-百思不得其解
//
//  Created by yhp on 2016/12/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopWindow.h"

@implementation YHPTopWindow
static  UIWindow* window_;

+(void)initialize
{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake(0, 0, YHPScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = YHPGlobalBgWithAlpha(0.1);
    window_.rootViewController = [[UIViewController alloc]init];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}


/**
 * 监听窗口点击
 */
+(void)windowClick
{
    // 1,scrollView
    // 2,keyWindow
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollView:window];
}


/**
 * 查找UIScrollView
 @param superView 父控件
 */
+(void)searchScrollView:(UIView*)superView
{
    for (UIScrollView* subview in superView.subviews) {
        // 如果是UIScrollView 就滚动
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = -subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollView:subview];
    }
}

/**
 * 显示窗口
 */
+(void)show
{
    window_.hidden = NO;
}

/**
 * 隐藏窗口
 */
+(void)hiden
{
   window_.hidden = YES;
}
@end

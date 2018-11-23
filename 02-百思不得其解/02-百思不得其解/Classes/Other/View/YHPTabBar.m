//
//  YHPTabBar.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/4.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTabBar.h"
#import "YHPPublishViewController.h"
@interface YHPTabBar ()
@property(nonatomic,weak)UIButton* publishButton;
@end

@implementation YHPTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton* publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        self.publishButton = publishButton;
        self.publishButton.size  = self.publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
    }
    return self;
}

/**
 窗口级别
 UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
 */
-(void)publishClick
{
//    YHPPublishView* publish = [YHPPublishView publishView];
////    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:NO completion:nil];
//    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//    publish.frame = window.bounds;
//    [window addSubview:publish];
    YHPPublishViewController* publishVc = [[YHPPublishViewController alloc]init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:NO completion:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //  设置发布按钮
    CGFloat width =  self.width;
    CGFloat height = self.height;
    self.publishButton.center = CGPointMake(width * 0.5,height * 0.5);
    // 设置其他按钮
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView* button in self.subviews) {
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            continue;
        }
        CGFloat buttonX = buttonW * (index > 1 ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
    
}


@end

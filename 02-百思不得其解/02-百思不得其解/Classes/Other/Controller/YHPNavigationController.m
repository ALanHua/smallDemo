//
//  YHPNavigationController.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/6.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPNavigationController.h"

@implementation YHPNavigationController

/**
 *  第一次使用这个类的时候使用
 */
+ (void)initialize
{
   // 方法-2 所有的导航栏都改了
    UINavigationBar* bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    // 设置item
    UIBarButtonItem* item = [UIBarButtonItem appearance];
    NSMutableDictionary* itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

-(void)loadView{
    [super loadView];
   
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 如果滑动移除控制的功能失效，清空代理这个功能会被重新设置
    self.interactivePopGestureRecognizer.delegate = nil;
}

/*
 * 可以在这里拦截push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        // 按钮内容左对齐
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.size = CGSizeMake(70, 100);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        // 影藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 如果viewController 想要替换可以自己改
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

@end

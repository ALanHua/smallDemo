//
//  UIBarButtonItem+YHPExtension.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "UIBarButtonItem+YHPExtension.h"

@implementation UIBarButtonItem (YHPExtension)

+(instancetype)itemWithImage:(NSString*)image highImage:(NSString*)highImage target:(id)target action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[self alloc]initWithCustomView:button];
}

@end

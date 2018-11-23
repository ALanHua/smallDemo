//
//  UIView+YHPExtension.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "UIView+YHPExtension.h"

@implementation UIView (YHPExtension)
/** set方法*/
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
/** get方法*/
-(CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

-(CGSize)size
{
    return self.frame.size;
}


/**
 * 判断一个控件是否真正显示在主窗口
 @return true or false
 */
-(BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    // 转换坐标系
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    // 判断是否在主窗口
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);

    return (!self.hidden) && (self.alpha > 0.01) && (self.window == keyWindow) && intersects;
}

/**
 从xib里加载
 @return
 */
+(instancetype)viewFromXib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end

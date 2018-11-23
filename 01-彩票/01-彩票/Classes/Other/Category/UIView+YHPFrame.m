//
//  UIView+YHPFrame.m
//  01-彩票
//
//  Created by yhp on 16/5/29.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "UIView+YHPFrame.h"

@implementation UIView (YHPFrame)

//centerY
- (CGFloat)centerY
{
    return self.centerY;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

// centerX
- (CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

//height
-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
//width
-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

// x
-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
// y
-(CGFloat)y
{
   return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

@end

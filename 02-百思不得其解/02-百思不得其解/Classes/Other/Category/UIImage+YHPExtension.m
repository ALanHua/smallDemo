//
//  UIImage+YHPExtension.m
//  02-百思不得其解
//
//  Created by yhp on 2017/1/17.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "UIImage+YHPExtension.h"

@implementation UIImage (YHPExtension)

/**
 将图片变成圆形图片返回
 @return UIImage
 */
-(UIImage*)circleImage
{
    // 开启绘图
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭绘图
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*)imageWithName:(NSString*)name
{
    NSString* dir = nil;
    NSString* path = [NSString stringWithFormat:@"Sking/%@%@",dir,name];
    
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:path ofType:nil]];
}



@end

//
//  UIImage+YHPImage.m
//  01-彩票
//
//  Created by yhp on 16/5/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "UIImage+YHPImage.h"

@implementation UIImage (YHPImage)

+(instancetype)imgaeWithOriRenderingImage:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+(instancetype)imageWithstretchableImage:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5 ];
}

@end

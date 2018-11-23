//
//  UIImage+YHPImage.h
//  01-彩票
//
//  Created by yhp on 16/5/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YHPImage)

// 快速返回不要渲染的图片
+(instancetype)imgaeWithOriRenderingImage:(NSString*)imageName;
+(instancetype)imageWithstretchableImage:(NSString*)imageName;
@end

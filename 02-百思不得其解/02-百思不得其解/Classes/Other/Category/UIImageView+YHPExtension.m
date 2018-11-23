//
//  UIImageView+YHPExtension.m
//  02-百思不得其解
//
//  Created by yhp on 2017/1/17.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "UIImageView+YHPExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (YHPExtension)

-(void)setCircleHeader:(NSString*)url
{
    UIImage* placeHolder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeHolder;
    }];
}

@end

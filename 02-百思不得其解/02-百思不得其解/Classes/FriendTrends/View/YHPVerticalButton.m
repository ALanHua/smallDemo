//
//  YHPVerticalButton.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPVerticalButton.h"

@implementation YHPVerticalButton


-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width  = self.width;
    self.imageView.height = self.imageView.width;
     // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y =  self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    // 调整图片
//    self.imageView.x = 0;
//    self.imageView.y = 0;
//    // 调整文字
//    self.titleLabel.x = 0;
//    self.titleLabel.y =  self.imageView.height;
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.titleLabel.y;
//}


@end

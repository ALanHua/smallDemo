//
//  YHPTittleView.m
//  01-彩票
//
//  Created by yhp on 16/6/1.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTittleView.h"

@implementation YHPTittleView

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.x < self.titleLabel.x) {
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end

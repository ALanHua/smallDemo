//
//  YHPProgressView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/27.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPProgressView.h"

@implementation YHPProgressView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
    self.progressTintColor = [UIColor grayColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    // 设置参数
    NSString* text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = text;
}

@end

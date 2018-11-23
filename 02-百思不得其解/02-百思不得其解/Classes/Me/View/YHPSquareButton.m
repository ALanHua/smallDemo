//
//  YHPSquareButton.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/13.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPSquareButton.h"
#import "YHPSquare.h"
#import <UIButton+WebCache.h>
@implementation YHPSquareButton

-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
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
    self.imageView.y = self.height * 0.15;
    self.imageView.width  = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y =  CGRectGetMaxY(self.imageView.frame);;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

/**
 模型赋值给控件
 @param square 模型数据
 */
- (void)setSquare:(YHPSquare *)square
{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}

@end

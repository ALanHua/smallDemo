//
//  YHPTagButton.m
//  02-百思不得其解
//
//  Created by yhp on 2017/3/8.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPTagButton.h"

@implementation YHPTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YHPTagBg;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * YHPTagMargin;
    self.height = YHPTagH;
}


/**
 重新布局
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = YHPTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + YHPTagMargin;
}

@end

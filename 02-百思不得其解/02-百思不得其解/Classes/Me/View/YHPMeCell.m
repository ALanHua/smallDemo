//
//  YHPMeCell.m
//  02-百思不得其解
//
//  Created by yhp on 2017/2/9.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import "YHPMeCell.h"

@implementation YHPMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置背景图片
        UIImageView* bgView = [[UIImageView alloc]init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];;
        self.backgroundView = bgView;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height  * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YHPTopicCellMargin;
}

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - YHPTopicCellMargin);
//    [super setFrame:frame];
//    
//}

@end

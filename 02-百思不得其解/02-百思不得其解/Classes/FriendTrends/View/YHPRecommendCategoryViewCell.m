//
//  YHPRecommendCategoryViewCell.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPRecommendCategoryViewCell.h"
#import "YHPRecommendCategory.h"

@interface YHPRecommendCategoryViewCell ()

// 选中时的指示器控件
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation YHPRecommendCategoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = YHPRGBColor(244 , 244, 244);
    self.selectedIndicator.backgroundColor = YHPRGBColor(219 , 21, 26);
}

- (void)setCategory:(YHPRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height -2 * self.textLabel.y;
}

/**
 *  监听cell的选中和取消
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : YHPRGBColor(78 , 78, 78);
}

@end

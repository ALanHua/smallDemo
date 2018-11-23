//
//  YHPCommentHeaderView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/12/20.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCommentHeaderView.h"

@interface YHPCommentHeaderView ()
/** 文字标签 */
@property(nonatomic,weak)UILabel* label;
@end

@implementation YHPCommentHeaderView

+(instancetype)headerViewWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"header";
    YHPCommentHeaderView* header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[YHPCommentHeaderView alloc]initWithReuseIdentifier:ID];
    }
    
    return header;
}



-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 先从缓存池找header
        self.contentView.backgroundColor = YHPGlobalBg;
        // 创建label
        UILabel* label = [[UILabel alloc]init];
        label.textColor = YHPRGBColor(67, 67, 67);
        label.width = 200;
//        label.x = YHPTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = _title;
}


@end

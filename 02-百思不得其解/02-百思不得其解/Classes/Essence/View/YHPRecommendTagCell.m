//
//  YHPRecommendTagCell.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPRecommendTagCell.h"
#import "YHPRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface YHPRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumber;


@end

@implementation YHPRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(YHPRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView setCircleHeader:recommendTag.image_list];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString* subNumebr = nil;
    if (recommendTag.sub_number < 10000) {
        subNumebr = [NSString stringWithFormat:@"%zd多少人订阅",recommendTag.sub_number];
    }else{
        subNumebr = [NSString stringWithFormat:@"%.1f万订阅",recommendTag.sub_number / 10000.0];
    }
    self.subNumber.text = subNumebr;
}

/**
 *  分割线技巧
 */
- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = 10;
//    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end

//
//  YHPRecommendUserCell.m
//  02-百思不得其解
//
//  Created by yhp on 16/9/9.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPRecommendUserCell.h"
#import "YHPRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface YHPRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation YHPRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUser:(YHPRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    NSString* fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd多少人关注"  ,user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView setCircleHeader:user.header];
}

@end

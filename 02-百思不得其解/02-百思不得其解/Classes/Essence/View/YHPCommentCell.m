//
//  YHPCommentCell.m
//  02-百思不得其解
//
//  Created by yhp on 2016/12/28.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPCommentCell.h"
#import "YHPComment.h"
#import <UIImageView+WebCache.h>
#import "YHPUser.h"


@interface YHPCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end


@implementation YHPCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView* bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];;
    self.backgroundView = bgView;
    
}

- (void)setComment:(YHPComment *)comment
{
    _comment = comment;
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    self.sexImageView.image = [comment.user.sex isEqualToString:YHPUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
        
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    if (comment.voiceurl.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    //frame.origin.x = YHPTopicCellMargin;
    //frame.size.width -= 2 * YHPTopicCellMargin;
    
    [super setFrame:frame];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end

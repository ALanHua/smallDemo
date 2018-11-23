//
//  YHPTopicVideoView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/12/1.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopicVideoView.h"
#import "YHPTopic.h"
#import <UIImageView+WebCache.h>
#import "YHPShowPictureViewController.h"

@interface YHPTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end
@implementation YHPTopicVideoView

+(instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}

-(void)showPicture
{
    YHPShowPictureViewController* showPicture = [[YHPShowPictureViewController alloc]init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow
     .rootViewController presentViewController:showPicture animated:YES completion:nil];
}

-(void)setTopic:(YHPTopic *)topic
{
    _topic = topic;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end

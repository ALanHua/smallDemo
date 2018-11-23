//
//  YHPTopicVoiceView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/11/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopicVoiceView.h"
#import "YHPTopic.h"
#import <UIImageView+WebCache.h>
#import "YHPShowPictureViewController.h"

@interface YHPTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end


@implementation YHPTopicVoiceView

+(instancetype)voiceView
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
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end

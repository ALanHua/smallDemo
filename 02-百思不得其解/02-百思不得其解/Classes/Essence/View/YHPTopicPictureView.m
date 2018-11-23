//
//  YHPTopicPictureView.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/18.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopicPictureView.h"
#import "YHPTopic.h"
#import <UIImageView+WebCache.h>
#import "YHPProgressView.h"
#import "YHPShowPictureViewController.h"

@interface YHPTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet YHPProgressView *progressView;
@end

@implementation YHPTopicPictureView

+(instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}

-(void)showPicture
{
    YHPShowPictureViewController* showPicture = [[YHPShowPictureViewController alloc]init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow
     .rootViewController presentViewController:showPicture animated:YES completion:nil];
    
}
- (void)setTopic:(YHPTopic *)topic
{
    /*最准确取出图片的第一个字节，判断图片类型*/
    _topic = topic;
    // 显示进度值
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]  placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize /  expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
        if (topic.isBigPicture == NO) {
            return;
        }
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureViewFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width ;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    // 判断ggif
    NSString* extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    // 判断是否显示点击全图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
      self.seeBigButton.hidden = YES;
//      self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end

//
//  YHPTopicCell.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/9.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopicCell.h"
#import "YHPTopic.h"
#import <UIImageView+WebCache.h>
#import "YHPTopicPictureView.h"
#import "YHPTopicVoiceView.h"
#import "YHPTopicVideoView.h"
#import "YHPComment.h"
#import "YHPUser.h"

@interface YHPTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVVIew;
/*帖子的文字内容*/
@property (weak, nonatomic) IBOutlet UILabel *test_label;

/** 图片帖子内容  */
@property(nonatomic,weak)YHPTopicPictureView* pictureView;
/** 声音帖子内容  */
@property(nonatomic,weak)YHPTopicVoiceView* voiceView;
/** 视频帖子内容  */
@property(nonatomic,weak)YHPTopicVideoView* videoView;

/* 最热评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/* 最热评论整体*/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation YHPTopicCell


/**
 创建cell
 @return YHPTopicCell
 */
+(instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


/*懒加载*/
- (YHPTopicPictureView *)pictureView
{
    if (!_pictureView) {
        YHPTopicPictureView* pictureView = [YHPTopicPictureView pictureView];
         [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(YHPTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        YHPTopicVoiceView* voiceView = [YHPTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (YHPTopicVideoView *)videoView
{
    if (!_videoView) {
        YHPTopicVideoView* videoView = [YHPTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

/**
 加载xib
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView* bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];;
    self.backgroundView = bgView;
}
/*
 今年
    今天
        1分钟内
            刚刚
        1小时前
            xx分钟
        其他
            xx小时前
    昨天
        昨天 20：50：54
    其他
        10-11 20：50：54
 非今年
    -- 2015-10-12 10:50:40
 */
- (void)setTopic:(YHPTopic *)topic
{
    _topic = topic;
    
    // 设置其他控件
    [self.profileImageView setCircleHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.sinaVVIew.hidden = !topic.isSina_v;
    [self setupButtonTittle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTittle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTittle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTittle:self.commentButton count:topic.comment placeholder:@"评论"];
    // 设置帖子内容
    self.test_label.text = topic.text;
    // 根据帖子类型添加对应的内容到cell的中间
    if (topic.type == YHPTopicPictureType) {
         self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == YHPTopicVoiceType){
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == YHPTopicVideoType){
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{
       self.voiceView.hidden = YES;
       self.videoView.hidden = YES;
       self.pictureView.hidden = YES;
    }
    // 处理最热评论内容
    YHPComment* cmt = topic.top_cmt;
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@,%@",cmt.user.username,cmt.content];
    }else{
        self.topCmtView.hidden = YES;
    }

}

-(void)setupButtonTittle:(UIButton*)button count:(NSInteger)count placeholder:(NSString*)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    //frame.origin.x = YHPTopicCellMargin;
    //frame.size.width -= 2 * YHPTopicCellMargin;
//    frame.size.height -= YHPTopicCellMargin;
    frame.size.height = self.topic.cellHeight - YHPTopicCellMargin;
    frame.origin.y += YHPTopicCellMargin;
    
    [super setFrame:frame];
}

-(void)testDate:(NSString*)create_time
{
 
    NSDateFormatter* fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* create = [fmt dateFromString:create_time];
    NSDate* now = [NSDate date];
    NSDateComponents* comps = [now deltaFrom:create];
    NSLog(@"%@,%@",create,now);
    NSLog(@"%zd %zd %zd %zd %zd %zd",comps.year,comps.month,comps.day,comps.hour,comps.minute,comps.second);
    
}
- (IBAction)more {
/**
  接口废弃
 //    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
 //    [sheet showInView:self.window];
 */
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 收藏
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    // 举报
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    // 取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end

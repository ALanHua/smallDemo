//
//  YHPTopic.h
//  02-百思不得其解
//
//  Created by yhp on 2016/10/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPComment;

@interface YHPTopic : NSObject

/** id */
@property(nonatomic,copy)NSString* ID;
/** 名称 */
@property(nonatomic,copy)NSString* name;
/** 头像 */
@property(nonatomic,copy)NSString* profile_image;
/** 发帖时间 */
@property(nonatomic,copy)NSString* create_time;
/** 文字内容 */
@property(nonatomic,copy)NSString* text;
/** 顶的数量 */
@property(nonatomic,assign)NSInteger ding;
/** 踩的数量 */
@property(nonatomic,assign)NSInteger cai;
/** 转发的数量 */
@property(nonatomic,assign)NSInteger repost;
/** 评论的数量 */
@property(nonatomic,assign)NSInteger comment;
/** 是否是新浪加V用户 */
@property(nonatomic,assign,getter=isSina_v)BOOL sina_v;
/** 图片的高度 */
@property(nonatomic,assign)CGFloat width;
/** 图片的高度 */
@property(nonatomic,assign)CGFloat height;
/** 图片路径 */
@property(nonatomic,copy)NSString* small_image;
@property(nonatomic,copy)NSString* large_image;
@property(nonatomic,copy)NSString* middle_image;
/** 帖子类型 */
@property(nonatomic,assign)YHPTopicType type;
/** 音频时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 播放次数 */
@property(nonatomic,assign)NSInteger playcount;
/** 视频时长 */
@property(nonatomic,assign)NSInteger videotime;
/** 最热评论 期望存放YHPComment模型*/
@property(nonatomic,strong)YHPComment* top_cmt;
/*******************************************/
/**额外的属性 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;
/** 图片控件的frame */
@property(nonatomic,assign,readonly)CGRect pictureViewFrame;
/** 图片是否太大 */
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;
/** 图片下载进度 */
@property(nonatomic,assign)CGFloat pictureProgress;
/** 声音控件的frame */
@property(nonatomic,assign,readonly)CGRect voiceViewFrame;
/** 视频控件的frame */
@property(nonatomic,assign,readonly)CGRect videoViewFrame;
@end

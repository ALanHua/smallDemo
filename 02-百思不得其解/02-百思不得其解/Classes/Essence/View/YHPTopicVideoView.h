//
//  YHPTopicVideoView.h
//  02-百思不得其解
//
//  Created by yhp on 2016/12/1.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPTopic;

@interface YHPTopicVideoView : UIView
/** 帖子数据 */
@property(nonatomic,strong)YHPTopic* topic;

+(instancetype)videoView;
@end

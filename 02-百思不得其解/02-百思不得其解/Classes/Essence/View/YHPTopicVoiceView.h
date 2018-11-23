//
//  YHPTopicVoiceView.h
//  02-百思不得其解
//
//  Created by yhp on 2016/11/30.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPTopic;
@interface YHPTopicVoiceView : UIView
/** 帖子数据 */
@property(nonatomic,strong)YHPTopic* topic;

+(instancetype)voiceView;
@end

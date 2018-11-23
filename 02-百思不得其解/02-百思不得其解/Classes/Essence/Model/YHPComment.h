//
//  YHPComment.h
//  02-百思不得其解
//
//  Created by yhp on 2016/12/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHPUser;

@interface YHPComment : NSObject

/** ID */
@property(nonatomic,copy)NSString* ID;
/** 音频文件时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 音频文件路径 */
@property(nonatomic,copy)NSString* voiceurl;
/** 评论内容 */
@property(nonatomic,copy)NSString* content;
/** 被点赞数量 */
@property(nonatomic,assign)NSInteger like_count;
/** 用户 */
@property(nonatomic,strong)YHPUser* user;
@end

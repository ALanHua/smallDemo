//
//  YHPCommentViewController.h
//  02-百思不得其解
//
//  Created by yhp on 2016/12/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPTopic;

@interface YHPCommentViewController : UIViewController

/** 帖子模型 */
@property(nonatomic,strong)YHPTopic* topic;
@end

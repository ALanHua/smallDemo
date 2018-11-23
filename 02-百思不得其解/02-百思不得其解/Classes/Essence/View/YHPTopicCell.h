//
//  YHPTopicCell.h
//  02-百思不得其解
//
//  Created by yhp on 2016/10/9.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHPTopic;

@interface YHPTopicCell : UITableViewCell

/** 梯子数据 */
@property(nonatomic,strong)YHPTopic* topic;

+(instancetype)cell;

@end

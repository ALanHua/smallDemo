//
//  YHPRecommendTag.h
//  02-百思不得其解
//
//  Created by yhp on 16/9/13.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPRecommendTag : NSObject
/** 图片 */
@property(nonatomic,copy)NSString* image_list;
/** 名字 */
@property(nonatomic,copy)NSString* theme_name;
/** 订阅数 */
@property(nonatomic,assign)NSInteger sub_number;

@end

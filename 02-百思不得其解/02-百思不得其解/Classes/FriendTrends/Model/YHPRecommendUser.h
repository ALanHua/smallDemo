//
//  YHPRecommendUser.h
//  02-百思不得其解
//
//  Created by yhp on 16/9/9.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPRecommendUser : NSObject

/** 头像 */
@property(nonatomic,copy)NSString* header;
/** 粉丝 */
@property(nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property(nonatomic,copy)NSString* screen_name;

@end

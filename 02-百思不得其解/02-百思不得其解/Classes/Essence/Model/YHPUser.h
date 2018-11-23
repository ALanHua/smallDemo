//
//  YHPUser.h
//  02-百思不得其解
//
//  Created by yhp on 2016/12/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPUser : NSObject
/** 用户名 */
@property(nonatomic,copy)NSString* username;
/** 性别 */
@property(nonatomic,copy)NSString* sex;
/** 头像 */
@property(nonatomic,copy)NSString* profile_image;

@end

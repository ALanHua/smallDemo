//
//  YHPLoginTool.h
//  02-百思不得其解
//
//  Created by yhp on 2017/3/27.
//  Copyright © 2017年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPLoginTool : NSObject


+(void)setUid:(NSString*)uid;

+(NSString*)getUid;
+(NSString*)getUid:(BOOL)showLoginController;

@end

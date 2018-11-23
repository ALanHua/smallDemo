//
//  YHPSaveTool.h
//  01-彩票
//
//  Created by yhp on 16/6/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//  专门用来存储的业务类

#import <Foundation/Foundation.h>

@interface YHPSaveTool : NSObject

+(id)objectForKey:(NSString *)defaultName;
+(void)setObject:(id)value forKey:(NSString *)defaultName;

@end

//
//  NSObject+Model.h
//  01-彩票
//
//  Created by yhp on 16/6/15.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+(instancetype)objcWithDict:(NSDictionary*)dict mapDict:(NSDictionary*)mapDict;

@end

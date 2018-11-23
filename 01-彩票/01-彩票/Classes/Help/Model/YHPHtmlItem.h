//
//  YHPHtmlItem.h
//  01-彩票
//
//  Created by yhp on 16/6/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPHtmlItem : NSObject

@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* html;
@property(nonatomic,strong)NSString* ID;

+(instancetype)itemWithDict:(NSDictionary*)dict;

@end

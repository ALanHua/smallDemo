//
//  YHPHtmlItem.m
//  01-彩票
//
//  Created by yhp on 16/6/14.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPHtmlItem.h"

@implementation YHPHtmlItem

+(instancetype)itemWithDict:(NSDictionary*)dict
{
    YHPHtmlItem* item = [self objcWithDict:dict mapDict:@{@"ID":@"id"}];
    
//    NSLog(@"%@",item.ID);
//    [item setValuesForKeysWithDictionary:dict];
    // 变量模型中属性名取字典中，如果找到就赋值

    
    return item;
}

//- (void)setValue:(id)value forKey:(NSString *)key
//{
//    if ([key isEqualToString:@"id"]) {
//        
//        [self setValue:value forKey:@"ID"];
//    }else{
//        [super setValue:value forKey:key];
//    }
//}

@end

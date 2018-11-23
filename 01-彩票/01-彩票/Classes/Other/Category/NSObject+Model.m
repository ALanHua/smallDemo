//
//  NSObject+Model.m
//  01-彩票
//
//  Created by yhp on 16/6/15.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+(instancetype)objcWithDict:(NSDictionary*)dict mapDict:(NSDictionary*)mapDict
{
    id objc = [[self alloc]init];
    //   变量模型中的属性
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList(self, &count);
    
    for (int i = 0; i < count; i++) {
        Ivar iva = ivars[i];
        NSString* ivaName = @(ivar_getName(iva));
        //  属性名称
        ivaName = [ivaName substringFromIndex:1];
        id value = dict[ivaName];
        //  ID --> 小写的Iid
        if (value == nil) {
            if (mapDict) {
                //  key 名称
                NSString* keyName = mapDict[ivaName];
                value = dict[keyName];
            }
        }
        [objc setValue:value forKey:ivaName];
    }
    
    return objc;
}

@end

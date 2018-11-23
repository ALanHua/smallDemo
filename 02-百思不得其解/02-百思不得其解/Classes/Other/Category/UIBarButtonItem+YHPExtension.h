//
//  UIBarButtonItem+YHPExtension.h
//  02-百思不得其解
//
//  Created by yhp on 16/9/5.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YHPExtension)

+(instancetype)itemWithImage:(NSString*)image highImage:(NSString*)highImage target:(id)target action:(SEL)action;

@end

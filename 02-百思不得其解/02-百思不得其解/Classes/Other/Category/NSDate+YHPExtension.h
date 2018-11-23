//
//  NSDate+YHPExtension.h
//  02-百思不得其解
//
//  Created by yhp on 2016/10/11.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YHPExtension)
/*比较时间差值*/
-(NSDateComponents*)deltaFrom:(NSDate*)from;
/*是否是今年*/
-(BOOL)isThisYear;
/*是否是今天*/
-(BOOL)isToday;
/*是否是昨天*/
-(BOOL)isYesterday;


@end

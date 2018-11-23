//
//  NSDate+YHPExtension.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/11.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "NSDate+YHPExtension.h"

@implementation NSDate (YHPExtension)
-(NSDateComponents*)deltaFrom:(NSDate*)from
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    // 比较时间
    NSCalendarUnit unit =  NSCalendarUnitYear   | NSCalendarUnitMonth
                         | NSCalendarUnitDay    | NSCalendarUnitHour
                         | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate: from toDate:self options:0];
}

-(BOOL)isThisYear
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYesr =  [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYesr;
}

-(BOOL)isToday
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay;
    NSDateComponents* nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents* selfCmps = [calendar components:unit fromDate:self];
    return (nowCmps.year == selfCmps.year) && (nowCmps.month == selfCmps.month) && (nowCmps.day == selfCmps.day);
}
-(BOOL)isTodayTwo
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* nowString = [fmt stringFromDate:[NSDate date]];
    NSString* selfString = [fmt stringFromDate:self];
    return  [nowString isEqualToString:selfString];
}

-(BOOL)isYesterday
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate* nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate* selfDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay;
    NSDateComponents* cmps = [calendar components:unit fromDate:nowDate toDate:selfDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}


@end

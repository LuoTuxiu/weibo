//
//  NSDate+Extension.m
//  myweibo
//
//  Created by 徐磊 on 15/12/22.
//  Copyright © 2015年 test. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
-(BOOL)isThisYear{
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar  =  [NSCalendar currentCalendar];
    
    NSDateComponents *createDareCmp =  [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowCmp =  [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return createDareCmp.year == nowCmp.year;
}

-(BOOL)isYesterday
{
    
    
    NSDateFormatter *fmt  = [[NSDateFormatter alloc]init];
    fmt.dateFormat   = @"YYYY-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr  = [fmt stringFromDate:[NSDate date]];
    //再转一次，去掉小时分钟秒
    NSDate * date2 =  [fmt dateFromString:dateStr];
    NSDate * now2 =  [fmt dateFromString:nowStr];
    
    //计算两个日期的差值
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar  =  [NSCalendar currentCalendar];
    NSCalendarUnit uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *compoment =   [calendar components:uint fromDate:date2 toDate:now2 options:0];
    return compoment.day== 1  && compoment.month == 0 && compoment.year == 0;
    
}

-(BOOL)isToday
{
    NSDateFormatter *fmt  = [[NSDateFormatter alloc]init];
    fmt.dateFormat   = @"YYYY-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr  = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}
@end

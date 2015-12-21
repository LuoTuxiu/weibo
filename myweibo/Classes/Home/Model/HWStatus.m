//
//  HWStatus.m
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhotos.h"
@implementation HWStatus
//在这里用这个类方法告诉编译器，数组pic_urls要转成模型HWPhotos类
+(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[HWPhotos class]};
}

//重写getter方法
-(NSString *)created_at
{
//    return @"刚刚";


    //今年
    
    //今天
    //刚刚：1分钟内发的
    //1-59分钟的：xx分钟前
    //大于60分钟的；
    
    //昨天
    //昨天 xx-xx;
    
    //其它
    //xxxx-xx-xx;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期格式:声明字符串每个数字和单词的含义
    //如果真机，需要设置locate才行,要不然为null
    fmt.locale  = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//    Mon Dec 21 21:44:27 +0800 2015
//    EEE
//    MMM
//    dd
//    HH
//    :mm
//    :ss Z
//    yyyy

    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *creatDate = [fmt dateFromString:_created_at];
    
    //当前时间
    NSDate *now  = [NSDate date];
    
//    //返回creatDate距离现在多少秒
//    NSTimeInterval seconds =   [creatDate timeIntervalSinceNow];
    
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar  =  [NSCalendar currentCalendar];
    NSCalendarUnit uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSLog(@"%@,,,%@",creatDate,now);
    //计算两个日期的差值
    NSDateComponents *compoment =   [calendar components:uint fromDate:creatDate toDate:now options:0];
//    compoment.minute代表相差了多少；
    NSLog(@"compoment%@",compoment);

    //可以转换calendar成年月日或者其它属性
    NSDateComponents *createDareCmp =  [calendar components:uint fromDate:creatDate];
    
    NSDateComponents *nowCmp =  [calendar components:uint fromDate:now];
    
    
    if ([self isThisYear:creatDate]) {//今年
        if ([self isYesterday:creatDate]) {
            fmt.dateFormat  =  @"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }else if ([self isToday:creatDate]){
            if (compoment.hour >=  1) {//    //大于60分钟的；
                return [NSString stringWithFormat:@"%ld小时前",(long)compoment.hour];
            } else if(compoment.minute >= 1){
                    return [NSString stringWithFormat:@"%ld分钟前",(long)compoment.minute];
            }else
            {
                return @"刚刚";
            }
        }
        else {
            fmt.dateFormat  =  @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
        
        
        
    } else {//非今年
        fmt.dateFormat  =  @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
    }
    NSLog(@"createDareCmp%@",createDareCmp);
    return _created_at;
    
}

-(BOOL)isThisYear:(NSDate *)date
{
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar  =  [NSCalendar currentCalendar];

    NSDateComponents *createDareCmp =  [calendar components:NSCalendarUnitYear fromDate:date];
    
    NSDateComponents *nowCmp =  [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return createDareCmp.year == nowCmp.year;
}

-(BOOL)isYesterday:(NSDate *)date
{

    
    NSDateFormatter *fmt  = [[NSDateFormatter alloc]init];
    fmt.dateFormat   = @"YYYY-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    
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

-(BOOL)isToday:(NSDate *)date
{
    NSDateFormatter *fmt  = [[NSDateFormatter alloc]init];
    fmt.dateFormat   = @"YYYY-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    
    NSString *nowStr  = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}
@end

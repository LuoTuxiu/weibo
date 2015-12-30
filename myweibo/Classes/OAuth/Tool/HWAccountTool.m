//
//  HWAccountTool.m
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWAccountTool.h"

#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation HWAccountTool

+(void)saveAccount:(HWAccount *)account
{
    //获得账号存储的时间（accessToken的产生时间）
//    NSDate *creatTime =  [NSDate date];
//    account.created_time   = creatTime;
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}


+(HWAccount *)account
{
    
    //加载模型
    HWAccount *account  =  [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    //验证账号是否过期,先转化数字类型
    long long expires_in = [account.expires_in longLongValue];
    
    //获得过期时间,左边的时间加上时间长得到一个时间
    NSDate *expiresTime =  [account.created_time dateByAddingTimeInterval:expires_in];
    //获取当前时间
    NSDate *now  =  [NSDate date];
    NSLog(@"%@  %@",expiresTime,now);
    //比较两者时间,如果now大于等于expiresTime
   NSComparisonResult result =  [expiresTime compare:now];
////    NSOrderedAscending = -1L,升序，右边大于左边
//    NSOrderedSame,
//    NSOrderedDescending，降序，右边小于左边
    if (result == NSOrderedAscending || result == NSOrderedSame) {
        return nil;
    }
    return account;
}
@end

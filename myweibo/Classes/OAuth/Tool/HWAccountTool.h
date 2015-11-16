//
//  HWAccountTool.h
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//  处理账号相关的操作:存储账号

#import <Foundation/Foundation.h>
@class HWAccount;
@interface HWAccountTool : NSObject
/**存储账号信息*/
+(void)saveAccount:(HWAccount *)account;

+(HWAccount *)account;
@end

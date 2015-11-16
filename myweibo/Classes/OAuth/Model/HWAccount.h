//
//  HWAccount.h
//  myweibo
//
//  Created by 徐磊 on 15/10/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>
/** */
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *expires_in;
@property (nonatomic,copy) NSString *uid;
/**  access_token获得时间*/
@property (nonatomic,strong) NSDate *created_time;


@property (nonatomic,copy) NSString *name;
+(instancetype)acocuntWithDict:(NSDictionary *)dict;

@end

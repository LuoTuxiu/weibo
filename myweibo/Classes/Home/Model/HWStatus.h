//
//  HWStatus.h
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWUser;
@interface HWStatus : NSObject
/**  字符串型的微博ID*/
@property (nonatomic,copy) NSString *idstr;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,strong) HWUser *user;

@end

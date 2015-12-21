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
//微博创建时间
@property (nonatomic,copy) NSString *created_at;
//微博来源
@property (nonatomic,copy) NSString *source;
//微博配图数组
@property (nonatomic,strong) NSArray *pic_urls;
//reposts_count	int	转发数


@property (nonatomic,assign) int reposts_count;
//comments_count	int	评论数
@property (nonatomic,assign) int comments_count;
//attitudes_count	int	表态数
@property (nonatomic,assign) int attitudes_count;
//转发微博属性
@property ( nonatomic ,strong) HWStatus *retweeted_status;
@end

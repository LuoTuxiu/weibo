//
//  HWUser.h
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    hwuserVerifiedTypeNone = -1,//没人任何资格
    hwuserVerifiedOrgEnterprice = 2,//没人任何资格
    hwuserVerifiedTypeOrgMedia = 3,//没人任何资格
    hwuserVerifiedPersonal = 0,//没人任何资格
    hwuserVerifiedWebsite = 5,//
    hwuserVerifiedDaren = 220 //微博达人
}HWUserVerified_type;

@interface HWUser : NSObject

@property (nonatomic,copy) NSString *name;
/**  字符串型的用户UID*/
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *profile_image_url;
//会员等级
@property (nonatomic,assign) int mbrank;
//会员类型 值>2 才代表是会员
@property (nonatomic,assign) int mbtype;
//认证类型
@property (nonatomic,assign) HWUserVerified_type verified_type;
@property (nonatomic,assign,getter=isVip) BOOL vip;
@end

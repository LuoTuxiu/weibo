//
//  HWUser.h
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUser : NSObject

@property (nonatomic,copy) NSString *name;
/**  字符串型的用户UID*/
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *profile_image_url;


@end

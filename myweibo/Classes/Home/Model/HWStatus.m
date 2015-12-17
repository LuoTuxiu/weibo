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
-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[HWPhotos class]};
}
@end

//
//  HWUser.m
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser
//转模型的时候才会调用
-(void)setMbtype:(int)mbtype
{
    _mbtype  = mbtype;
    self.vip = mbtype > 2;
}
//-(BOOL)isVip
//{
//    return self.mbrank > 2;
//}
@end

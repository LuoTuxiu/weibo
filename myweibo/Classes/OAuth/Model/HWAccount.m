//
//  HWAccount.m
//  myweibo
//
//  Created by 徐磊 on 15/10/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount
+(instancetype)acocuntWithDict:(NSDictionary *)dict
{
    HWAccount *account = [[self alloc]init];
    account.access_token  =  dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.created_time = [NSDate date];
    return account;
}

//当一个对象要归档进沙盒中时，就会调用此方法
//目的：在这个方法中说明这个对象的哪些属性要存进沙盒
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}


//当从沙盒中解档一个对象时，就会调用这个方法
//目的：在这个方法中说明沙盒中的属性该怎么解析
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token   = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in  =  [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid =  [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name  = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end

//
//  UIWindow+Extension.m
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HMMainTabBarController.h"
#import "HWNewFeatureViewController.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController
{
    //切换窗口的根控制器
    //拿出存储在沙盒中的版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion =[[NSUserDefaults standardUserDefaults]objectForKey:key];
    //获得当前软件的版本号（从plist中获取）
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = info[key];
    //    NSLog(@"%@",currentVersion);
    
//    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {//意外着这次打开和上次打开的是同样的版本
        
        self.rootViewController = [[HMMainTabBarController alloc]init];
    }
    else{
        self.rootViewController = [[HWNewFeatureViewController alloc]init];
        //将读出来的版本号读进沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
@end

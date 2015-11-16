//
//  AppDelegate.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/26.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "AppDelegate.h"
#import "HWOAuthViewController.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
   //设置根控制器
    
    //新浪授权显示界面
    
//    //沙盒路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
//    
//    //加载沙盒里面的存的信息
////    NSDictionary *account =  [NSDictionary dictionaryWithContentsOfFile:path];
//    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    HWAccount *account = [HWAccountTool account];
    if (account) {  //如果account存在，则上次登陆成功过
        [self.window switchRootViewController];

    }
    else
    {
        self.window.rootViewController =  [[HWOAuthViewController alloc]init];
    }
    
    

    

    
    
//    self.window.rootViewController = [[HMMainTabBarController alloc]init];

    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr =  [SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    //2.清除内存中的所有的图片
    [mgr.imageCache clearMemory];
}

@end

//
//  AppDelegate.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/19.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window =  [[UIWindow alloc]init];
    self.window.frame  =  [UIScreen mainScreen].bounds;
    
    //2.设置根控制器
    UITabBarController *tabbatVc =  [[TabBarViewController alloc]init];
    self.window.rootViewController = tabbatVc;
    
    //3.设置子控制器
    //3.1方法1：
//    UIViewController *vc1 =  [[UIViewController alloc]init];
//    vc1.view.backgroundColor= RanColor;
//    vc1.tabBarItem.title = @"首页";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//    
////    默认情况下会对selectedImage进行渲染，导致该图片变成蓝色；
////    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"tabbar_home_selected"];
//    
//    //让selectedImage不要渲染的方法
//    UIImage *homeImage  = [UIImage imageNamed:@"tabbar_home_selected"];
//    //声明这张图片按照原始的样子显示出来，不要自动渲染成其它颜色
//    homeImage =  [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem.selectedImage =  homeImage;
//    
//    //设置item文字样式
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = Color(123, 123 ,123);
//    [vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
// 
//    //设置item选中文字样式
//    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [vc1.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
//    
//    UIViewController *vc2 =  [[UIViewController alloc]init];
//    vc2.view.backgroundColor= RanColor;
//    vc2.tabBarItem.title = @"消息";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//    
//    //    默认情况下会对selectedImage进行渲染，导致该图片变成蓝色；
//    //    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"tabbar_home_selected"];
//    
//    vc2.tabBarItem.selectedImage =  [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    //设置item文字样式
//    NSMutableDictionary *textAttrs2 = [NSMutableDictionary dictionary];
//    textAttrs2[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [vc2.tabBarItem setTitleTextAttributes:textAttrs2 forState:UIControlStateNormal];
//    
//    //设置item选中文字样式
//    NSMutableDictionary *selectedTextAttrs2 = [NSMutableDictionary dictionary];
//    selectedTextAttrs2[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [vc2.tabBarItem setTitleTextAttributes:selectedTextAttrs2 forState:UIControlStateSelected];
//    
//    UIViewController *vc3 =  [[UIViewController alloc]init];
//    vc3.view.backgroundColor= RanColor;
//    vc3.tabBarItem.title = @"发现";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//    
//    //    默认情况下会对selectedImage进行渲染，导致该图片变成蓝色；
//    //    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"tabbar_home_selected"];
//    
//    vc3.tabBarItem.selectedImage =  [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //设置item文字样式
//    NSMutableDictionary *textAttrs3 = [NSMutableDictionary dictionary];
//    textAttrs3[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [vc3.tabBarItem setTitleTextAttributes:textAttrs3 forState:UIControlStateNormal];
//    
//    //设置item选中文字样式
//    NSMutableDictionary *selectedTextAttrs3 = [NSMutableDictionary dictionary];
//    selectedTextAttrs3[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [vc3.tabBarItem setTitleTextAttributes:selectedTextAttrs3 forState:UIControlStateSelected];
//
//    
//    UIViewController *vc4 =  [[UIViewController alloc]init];
//    vc4.view.backgroundColor= RanColor;
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
//    
//    //    默认情况下会对selectedImage进行渲染，导致该图片变成蓝色；
//    //    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"tabbar_home_selected"];
//
//    vc4.tabBarItem.selectedImage =  [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //设置item文字样式
//    NSMutableDictionary *textAttrs4 = [NSMutableDictionary dictionary];
//    textAttrs4[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [vc4.tabBarItem setTitleTextAttributes:textAttrs4 forState:UIControlStateNormal];
//    
//    //设置item选中文字样式
//    NSMutableDictionary *selectedTextAttrs4 = [NSMutableDictionary dictionary];
//    selectedTextAttrs4[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    [vc4.tabBarItem setTitleTextAttributes:selectedTextAttrs4 forState:UIControlStateSelected];
    
    //3.2方法2

//    HomeTableViewController *home = [[HomeTableViewController alloc]init];
//    [self addChildVc:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
//    
//    MessageTableViewController *messageCenter = [[MessageTableViewController alloc]init];
//    [self addChildVc:messageCenter Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selectedd"];
//    
//    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc]init];
//    [self addChildVc:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
//    
//    ProfileTableViewController *profile = [[ProfileTableViewController alloc]init];
//    [self addChildVc:profile Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
  

    //将viewcontroller控制器添加到tabbarcontroller控制器
    //方法1：
//    tabbatVc.viewControllers = @[vc1,vc2,vc3,vc4];
    //方法2
//    [tabbatVc addChildViewController:home];
//    [tabbatVc addChildViewController:messageCenter];
//    [tabbatVc addChildViewController:discover];
//    [tabbatVc addChildViewController:profile];
//    
    //许多相同的重复代码--》将重复代码抽取到一个方法中
    //1.相同的代码放在一个方法中
    //2.不同的东西变成参数
    //3.在使用到这个代码的地方调用方法，传递函数
    
    //4显示窗口
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

@end

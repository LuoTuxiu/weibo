//
//  TabBarViewController.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoverTableViewController.h"
#import "ProfileTableViewController.h"
#import "NavigationController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.初始化子控制器
    //3.2方法2
    
    HomeTableViewController *home = [[HomeTableViewController alloc]init];
    [self addChildVc:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MessageTableViewController *messageCenter = [[MessageTableViewController alloc]init];
    [self addChildVc:messageCenter Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selectedd"];
    
    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc]init];
    [self addChildVc:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ProfileTableViewController *profile = [[ProfileTableViewController alloc]init];
    [self addChildVc:profile Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



-(void)addChildVc:(UIViewController *)childVc Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.view.backgroundColor= RanColor;
    //设置文字
//    方法1：
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;

//  方法2
    //同时设置tabbaritem的标题和nanvgation的标题
//    childVc.title = title;
    
        childVc.tabBarItem.image = [UIImage imageNamed:image];
    //    默认情况下会对selectedImage进行渲染，导致该图片变成蓝色；
    //    vc1.tabBarItem.selectedImage =  [UIImage imageNamed:@"tabbar_home_selected"];
    
    childVc.tabBarItem.selectedImage =  [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置item文字样式
    NSMutableDictionary *textAttrs4 = [NSMutableDictionary dictionary];
    textAttrs4[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs4 forState:UIControlStateNormal];
    
    //设置item选中文字样式
    NSMutableDictionary *selectedTextAttrs4 = [NSMutableDictionary dictionary];
    selectedTextAttrs4[NSForegroundColorAttributeName] = [UIColor yellowColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs4 forState:UIControlStateSelected];
    
    //先给外面传输的控制器包装一个导航栏控制器
    NavigationController *nav =  [[NavigationController alloc] initWithRootViewController:childVc];
    //添加为子控制器：
    [self addChildViewController:nav];
    //    return childVc;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

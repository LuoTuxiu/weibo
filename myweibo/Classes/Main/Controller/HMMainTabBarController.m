//
//  HMMainTabBarController.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/26.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HMMainTabBarController.h"
#import "HMHomeTableViewController.h"
#import "HMMessageTableViewController.h"
#import "HMDiscoverTableViewController.h"
#import "HMProfileTableViewController.h"
#import "HMNavigationController.h"
#import "HWTabBar.h"
@interface HMMainTabBarController ()<HWTabBarDelegate>

@end

@implementation HMMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.初始化子控制器
        HMHomeTableViewController *vc1 = [[HMHomeTableViewController alloc]init];
        [self addChildVc:vc1 title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    
        HMMessageTableViewController *vc2 = [[HMMessageTableViewController alloc]init];
        [self addChildVc:vc2 title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
//    HMMessageTableViewController *vc5 = [[HMMessageTableViewController alloc]init];
//    [self addChildVc:vc5 title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
        HMDiscoverTableViewController *vc3 = [[HMDiscoverTableViewController alloc]init];
        [self addChildVc:vc3 title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
        HMProfileTableViewController *vc4 = [[HMProfileTableViewController alloc]init];
        [self addChildVc:vc4 title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //    tabBarVc.viewControllers = @[vc1];
//        [tabBarVc addChildViewController:vc1];
//        [tabBarVc addChildViewController:vc2];
//        [tabBarVc addChildViewController:vc3];
//        [tabBarVc addChildViewController:vc4];
    
    //更换系统tabbar
////    self.tabBar = [[HWTabBar alloc]init];
    HWTabBar *tabbar = [[HWTabBar alloc]init];
#warning 下面这行代码过后，则tabbar的代理就是HMMainTabBarController了
    [self setValue:tabbar forKeyPath:@"tabBar"];
   
    //reason: 'Changing the delegate of a tab bar managed by a tab bar controller is not allowed.'
//    tabbar.delegate = self;
//不允许修改tabbar的delegate属性（如果这个tabbar是tabbarViewcontroller所管理的）

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    childVc.view.backgroundColor = HMRandColor;
//    childVc.tabBarItem.title = title;//设置tabbar文字
//    childVc.navigationItem.title  = title;//设置导航栏的文字
    childVc.title = title;//同时设置tabbar和导航栏的文字
    NSMutableDictionary *textAttr =  [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    [childVc.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttr =  [NSMutableDictionary dictionary];
    selectedTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    childVc.tabBarItem.image =  [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage =  [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HMNavigationController *nav  = [[HMNavigationController alloc]initWithRootViewController:childVc];
    //添加为子控制器
    [self addChildViewController:nav];
    
}

#pragma mark 实现代理方法
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar
{
    UIViewController *vc  =  [[UIViewController alloc]init];
    vc.view.backgroundColor =[UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end

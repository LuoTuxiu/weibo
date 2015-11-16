//
//  HMNavigationController.m
//  微博大项目2
//
//  Created by xulei on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()

@end

@implementation HMNavigationController
//在类第一次使用的时候调用
+(void)initialize
{
//    [UINavigationBar appearance];//设置导航栏的颜色
    
    //设置item的主题
   UIBarButtonItem *item =  [UIBarButtonItem appearance];
    
    //设置普通颜色
    //key:NS*****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态下的主题颜色
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


/**
 *  拦截所有push进来的控制器
 *
 *  @param viewController <#viewController description#>
 *  @param animated       <#animated description#>
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{


    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
       
        viewController.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:YES];
}


-(void)back
{
    [self popViewControllerAnimated:YES];
}


-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end

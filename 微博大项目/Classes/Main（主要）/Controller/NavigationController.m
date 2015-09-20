//
//  NavigationController.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
//    NSLog(@"%d %@",self.viewControllers.count,viewController);
    
    if (self.viewControllers.count >0) {//说明这时候是第一个控制器
       
    viewController.hidesBottomBarWhenPushed = YES;
    
    //设置导航栏左边的返返回的按钮
        
    //设置图片
    UIButton *backBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    //设置监听
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    //设置尺寸,此时设置xy是无效的，因为它已经是left的item了。
    //因为新建了UIView+Extension，扩充了方法；
    backBtn.size =  backBtn.currentBackgroundImage.size;
    
    //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    //设置图片
    UIButton *moreBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    //设置监听
    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    //设置尺寸,此时设置xy是无效的，因为它已经是left的item了。
    //因为新建了UIView+Extension，扩充了方法；
    moreBtn.size =  moreBtn.currentBackgroundImage.size;
    
    viewController.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}


-(void)more
{
    //用户回到根控制器
    [self popToRootViewControllerAnimated:YES];
}
@end

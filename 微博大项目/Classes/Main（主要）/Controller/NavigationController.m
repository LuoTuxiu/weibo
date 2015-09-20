//
//  NavigationController.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

//
+(void)initialize
{
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item  =  [UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //这里的key一般都是attributeName的命名结尾
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    //这里的key一般都是attributeName的命名结尾
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [UIColor colorWithRed:1.0 green:1.0 blue:0.8 alpha:1.0]
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
//    NSLog(@"%d %@",self.viewControllers.count,viewController);
    
    if (self.viewControllers.count >0) {//说明这时候是第一个控制器
       
    viewController.hidesBottomBarWhenPushed = YES;
    
    //设置导航栏左边的返返回的按钮
        
//    //设置图片
//    UIButton *backBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
//    //设置监听
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    //设置尺寸,此时设置xy是无效的，因为它已经是left的item了。
//    //因为新建了UIView+Extension，扩充了方法；
//    backBtn.size =  backBtn.currentBackgroundImage.size;
//    
//    //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
        
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    
    
//    //设置图片
//    UIButton *moreBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
//    //设置监听
//    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//    //设置尺寸,此时设置xy是无效的，因为它已经是left的item了。
//    //因为新建了UIView+Extension，扩充了方法；
//    moreBtn.size =  moreBtn.currentBackgroundImage.size;
//    
//    viewController.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        
    viewController.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
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

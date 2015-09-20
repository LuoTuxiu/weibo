//
//  itemTool.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "itemTool.h"

@implementation itemTool

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
{
    
    //设置图片
    UIButton *Btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    //设置监听
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置尺寸,此时设置xy是无效的，因为它已经是left的item了。
    //因为新建了UIView+Extension，扩充了方法；
    Btn.size =  Btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
    ;
    
}

@end

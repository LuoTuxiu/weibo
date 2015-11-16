//
//  UIBarButtonItem+Extension.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *Btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置按钮尺寸,添加了分类，所以可以直接设置
    Btn.size = Btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}
@end

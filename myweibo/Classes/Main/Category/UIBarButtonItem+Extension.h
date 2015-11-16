//
//  UIBarButtonItem+Extension.h
//  微博大项目2
//
//  Created by 徐磊 on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end

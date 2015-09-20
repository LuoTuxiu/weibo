//
//  UIBarButtonItem+Extension.h
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    <#action description#>
 *  @param image     <#image description#>
 *  @param highImage <#highImage description#>
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end

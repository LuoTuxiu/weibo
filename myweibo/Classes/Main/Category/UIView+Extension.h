//
//  UIView+Extension.h
//  微博大项目2
//
//  Created by xulei on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//分类并不会生成下划线成员变量？
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@end

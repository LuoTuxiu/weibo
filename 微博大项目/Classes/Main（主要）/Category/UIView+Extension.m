//
//  UIView+Extension.m
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
-(void)setX:(CGFloat)x
{
    CGRect frame =  self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


-(void)setY:(CGFloat)y
{
    CGRect frame =  self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeigth:(CGFloat)heigth
{
    CGRect frame  = self.frame;
    frame.size.height = heigth;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)heigth
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect frame  = self.frame;
    frame.size = size;
    self.frame = frame;
 
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame  = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin
{
    return self.frame.origin;
}
@end

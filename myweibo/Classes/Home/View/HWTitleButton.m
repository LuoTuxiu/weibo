//
//  HWTitleButton.m
//  myweibo
//
//  Created by 徐磊 on 15/10/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWTitleButton.h"

@implementation HWTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置图片内容居中
        self.imageView.contentMode =  UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.titleLabel.backgroundColor =  [UIColor clearColor];
        self.imageView.backgroundColor =  [UIColor clearColor];
    }
    return self;
}

////contentRect == 按钮的bounds
//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width =  13;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}
//
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    CGFloat x = 0 ;
//    CGFloat y = 0 ;
//    //会死循环
////    NSMutableDictionary *attrs =  [NSMutableDictionary dictionary];
////    attrs[NSFontAttributeName] = self.titleLabel.font;
////    CGFloat width =  [self.currentTitle sizeWithAttributes:attrs].width;
//
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //如果仅仅是调整按钮内部titlelabel和imalabel的
    //1.计算label
    self.titleLabel.x = self.imageView.x;
//        NSMutableDictionary *attrs =  [NSMutableDictionary dictionary];
//        attrs[NSFontAttributeName] = self.titleLabel.font;
//        CGFloat width =  [self.currentTitle sizeWithAttributes:attrs].width;
    //2.计算imageView的frame
    self.imageView.x  = CGRectGetMaxX(self.titleLabel.frame);
//    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    
}
@end

//
//  HWTextView.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWTextView.h"

@implementation HWTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //当uitextview的文字发生改变时，uitextView自己会发出一个UITextFieldTextDidChangeNotification的通知
        //这里最好用self
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        //如果占位文字也要有拖拽效果的话就要用label，不能用draw；
//        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [self addSubview:btn];
    }
    return self;
}


//setNeedDisplay是在runloop是在下一次消息循环中调用一次drawRect
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//     Drawing code
//    NSString *str= @"哈哈";
    //因为有NSMutableDictionary，下面这句无效
//    [self.placeholderColor set];
    if (!self.hasText) {
        //文字属性
        NSMutableDictionary *attrs  = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = self.font;
        attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
//        [self.placeholderText drawAtPoint:CGPointMake(0, 0) withAttributes:attrs];
        
        [self.placeholderText drawInRect:CGRectMake(5, 8, rect.size.width -  2 * 5, rect.size.height - 2 * 8) withAttributes:attrs];
    }
    
}

-(void)textDidChange
{
    NSLog(@"textDidChange");
    //会自动调用drawRect
    [self setNeedsDisplay];
}

-(void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText  = [placeholderText copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
       [self setNeedsDisplay];
}


-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}


-(void)setFont:(UIFont *)font
{
    [super setFont:font ];
    [self setNeedsDisplay];
}
@end

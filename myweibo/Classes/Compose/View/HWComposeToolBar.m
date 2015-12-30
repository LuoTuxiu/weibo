//
//  HWComposeToolBar.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWComposeToolBar.h"

@implementation HWComposeToolBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" tag:HWComposeToolBarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:HWComposeToolBarButtonTypeAlbums];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:HWComposeToolBarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:HWComposeToolBarButtonTypeTrend];
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:HWComposeToolBarButtonTypeEmotion];
    }
    return self;
}


//创建一个按钮
-(void)setupBtn:(NSString *)image highImage:(NSString *)highImage tag:(HWComposeToolBarButtonType)tag
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick :) forControlEvents:UIControlEventTouchUpInside];
    btn.tag  = tag;
    [self addSubview:btn];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置所有按钮的frame
    NSUInteger count  = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH =  self.height;
    for ( NSUInteger i = 0; i < count; i++) {
        UIButton *btn  = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x  = i * btnW;
        btn.height = btnH;
    }
}


-(void)btnClick:(UIButton *)sender
{
    NSUInteger index = self.width /sender.x ;
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:sender.tag];
    }
//    NSLog(@"122424");
}

@end

//
//  HWStatusToolBar.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/19.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatusToolBar.h"

@implementation HWStatusToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)toolBar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
           }
    return self;
}

/**
 *  初始化一个按钮
 *
 *  @param title 标题
 *  @param icon  按钮图标
 */
-(void)setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn =  [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count  = self.subviews.count;
    CGFloat btnW  = self.width / count;
    CGFloat btnH  =  self.height;
    for (int i = 0; i< count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
        
    }
    
}
@end

//
//  HWTabBar.m
//  myweibo
//
//  Created by xulei on 15/10/28.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWTabBar.h"
@interface HWTabBar()
{
    
}

@property (nonatomic,weak) UIButton *plusBtn;
@end
@implementation HWTabBar

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
        //添加一个按钮到tabbar
        UIButton *plusBtn =  [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}


-(void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}


-(void)layoutSubviews
{
    //一定要调用
    [super layoutSubviews];
    
    //1.设置加号按钮的位置
//    self.plusBtn.centerX = self.width * 0.5;
//    self.plusBtn.centerX = 160;
    self.plusBtn.centerY =self.height * 0.5;
    self.plusBtn.x = self.size.width * 0.5 - self.plusBtn.width * 0.5;
    //2.设置剩下4个的tabbar的位置

    CGFloat tabbarButtonW = self.width / 5 ;
    CGFloat tabbarButtonIndex = 0 ;
    
    Class class =  NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {

        if ([child isKindOfClass:class]) {
//            NSLog(@"系统自带按钮");
            //设置宽度
            child.width =  tabbarButtonW;
            //设置x
            child.x = tabbarButtonIndex * tabbarButtonW;
            tabbarButtonIndex++ ;
            //加到2的时候再加1次
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
            
//            child.backgroundColor = [UIColor redColor];
        }
    }
}



@end

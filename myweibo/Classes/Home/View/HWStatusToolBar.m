//
//  HWStatusToolBar.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/19.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatusToolBar.h"
#import "HWStatus.h"
@interface HWStatusToolBar()
@property ( nonatomic ,weak) UIButton *retweetBtn;
@property ( nonatomic ,weak) UIButton *commentBtn;
@property ( nonatomic ,weak) UIButton *statusBtn;
@end
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
      self.retweetBtn =   [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
      self.commentBtn =  [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
       self.statusBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
           }
    return self;
}

/**
 *  初始化一个按钮
 *
 *  @param title 标题
 *  @param icon  按钮图标
 */
-(UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn =  [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;

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

-(void)setStatus:(HWStatus *)status
{
    _status  =status;
    //转发
    [self setupBtntitle:@"转发" count:status.reposts_count btn:self.retweetBtn];
    
    //评论
     [self setupBtntitle:@"评论" count:status.comments_count btn:self.commentBtn];
    
      //赞
    [self setupBtntitle:@"赞" count:status.attitudes_count btn:self.statusBtn];

    
    
    
}


-(void)setupBtntitle:(NSString *)title count:(int)count btn:(UIButton *)btn
{
    if (count) {//有数字
//不足10000
        if (count < 10000) {
            title  = [NSString stringWithFormat:@"%d",count];

        } else {
            double wan = count / 1000.0;
            title  = [NSString stringWithFormat:@"%.1f万",wan];
            title  = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

    }
    //更换字符串
    [btn setTitle:title forState:UIControlStateNormal];
    
}

@end

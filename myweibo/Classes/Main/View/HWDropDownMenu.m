//
//  HWDropDownMenu.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HWDropDownMenu.h"
@interface HWDropDownMenu()
{
    
}

//用来显示的容器
@property (nonatomic,weak) UIImageView *contentView;
@end
@implementation HWDropDownMenu

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
        self.backgroundColor  = [UIColor clearColor];
        
        //添加灰色图片控件
        UIImageView *contentMenu = [[UIImageView alloc]init];
    
        contentMenu.image =  [UIImage imageNamed:@"popover_background"];
    
//        contentMenu.width  = 217;
//        contentMenu.height  = 300;
        
        contentMenu.userInteractionEnabled = YES;
        _contentView  = contentMenu;
        [self addSubview:contentMenu];
        
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc]init];
}


-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    //设置内容的宽度
//    content.width = self.contentView.width - 2 * content.x;
    self.contentView.width  =  CGRectGetMaxX(content.frame) + 10;
    
    //设置灰色菜单的尺寸
    self.contentView.height = CGRectGetMaxY(content.frame) + content.y;

    [self.contentView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(void)showFrom:(UIView *)from
{
    //1.获得最上面的窗口
    UIWindow *window   = [[UIApplication sharedApplication].windows lastObject];
    
    //2.添加到自己窗口上
    [window addSubview:self];
    
    self.frame= window.bounds;

    //调整灰色图片位置
//    self.contentView.x = (self.width - self.contentView.width) * 0.5;
    //转换坐标系
    //默认情况下frame是以父控件左上角为坐标原点
    //可以通过转换坐标系原点来改变frame的参照点
    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    [from.superview convertRect:from.frame toView:nil];//与上句同样效果,写空也指的是window
    
    
//    CGRect newRect =  [window convertRect:from.bounds fromView:from];//与上句是同样的意思
    self.contentView.centerX = CGRectGetMidX(newFrame);
    self.contentView.y = CGRectGetMaxY(newFrame);
}


//销毁
-(void)dismiss
{

    if ([self.delegate respondsToSelector:@selector(DropDownMenuDidMiss:)]) {
        [self.delegate DropDownMenuDidMiss:self];
    }
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s",__func__);
    [self dismiss];
}
@end

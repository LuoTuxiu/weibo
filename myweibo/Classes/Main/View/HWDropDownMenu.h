//
//  HWDropDownMenu.h
//  微博大项目2
//
//  Created by 徐磊 on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropDownMenu;
@protocol HWDropDownMenuDelegate <NSObject>
@optional
-(void)DropDownMenuDidMiss:(HWDropDownMenu *)menu;
@end
@interface HWDropDownMenu : UIView
//内容
@property (nonatomic,strong) UIView *content;
@property (nonatomic,strong) UIViewController *contentController;

@property (nonatomic,weak) id<HWDropDownMenuDelegate> delegate;
+(instancetype)menu;
//show
-(void)showFrom:(UIView *)from;

-(void)dismiss;
@end

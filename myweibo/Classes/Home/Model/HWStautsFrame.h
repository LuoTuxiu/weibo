//
//  HWStautsFrame.h
//  myweibo
//
//  Created by 徐磊 on 15/12/16.
//  Copyright © 2015年 test. All rights reserved.
//  一个frame模型存放着一个cell内部所有的子空间的frame数据
//  还要存放一个cell的高度
//  还必须存放着一个数据模型
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
#define HWStatusCellTimeFont [UIFont systemFontOfSize:13]
#define HWStatusCellSourceFont [UIFont systemFontOfSize:13]
#import <Foundation/Foundation.h>
@class HWStatus;
@interface HWStautsFrame : NSObject
@property (nonatomic,strong) HWStatus *status;

//原创微博整体
@property (nonatomic,assign) CGRect originalViewFrame;
//头像
@property (nonatomic,assign) CGRect iconViewFrame;
//配图
@property (nonatomic,assign) CGRect photoViewFrame;
//会员图标
@property (nonatomic,assign) CGRect vipViewFrame;
//名称
@property (nonatomic,assign) CGRect nameLabelFrame;
//时间
@property (nonatomic,assign) CGRect timeLabelFrame;
//正文
@property (nonatomic,assign) CGRect contentLabelFrame;
//来源
@property (nonatomic,assign) CGRect sourceLabelFrame;

@property (nonatomic,assign) CGFloat cellHeight;
@end

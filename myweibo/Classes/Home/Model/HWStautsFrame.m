//
//  HWStautsFrame.m
//  myweibo
//
//  Created by 徐磊 on 15/12/16.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStautsFrame.h"
#import "HWStatus.h"
#import "HWUser.h"
#define HWStatusCellBorderW 10

@implementation HWStautsFrame
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSMutableDictionary *attrs  = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attrs];
}

-(void)setStatus:(HWStatus *)status
{
    
    _status  =status;
    HWUser *user = status.user;
//    //原创微博
//    //头像
//    @property (nonatomic,assign) CGRect iconViewFrame;
    CGFloat iconWH = 50;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewFrame  = CGRectMake(iconX, iconY, iconWH, iconWH);
//    //配图
//    @property (nonatomic,assign) CGRect photoViewFrame;
//    //名称
//    @property (nonatomic,assign) CGRect nameLabelFrame;
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame) + HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
//    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    self.nameLabelFrame = (CGRect){{nameX,nameY},nameSize};

//    //会员图标
//    @property (nonatomic,assign) CGRect vipViewFrame;
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + HWStatusCellBorderW;
        CGFloat vipY  = nameY;
        CGFloat vipH  = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }

//    //时间
//    @property (nonatomic,assign) CGRect timeLabelFrame;
    CGFloat timeX = nameX;
    CGFloat timeY  = CGRectGetMaxY(self.nameLabelFrame) + HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLabelFrame = (CGRect){{timeX,timeY},timeSize};
//    //正文
//    @property (nonatomic,assign) CGRect contentLabelFrame;
//    //来源
//    @property (nonatomic,assign) CGRect sourceLabelFrame;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabelFrame) + HWStatusCellBorderW;
    CGFloat sourceLabelY  = CGRectGetMaxY(self.nameLabelFrame) + HWStatusCellBorderW;
    CGSize sourceLabelSize = [self sizeWithText:status.created_at font:HWStatusCellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
//    @property (nonatomic,assign) CGFloat cellHeight;
//    //原创微博整体
//    @property (nonatomic,assign) CGRect originalViewFrame;
    self.cellHeight = 70;
}
@end

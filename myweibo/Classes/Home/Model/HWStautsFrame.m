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
    return [self sizeWithText:text font:font maxW:MAXFLOAT];

}
//根据最大宽度来算frame
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs  = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName]= [UIColor blackColor];
    attrs[NSFontAttributeName] = font;
//    NSLog(@"%@",font);
//    return [text sizeWithAttributes:attrs];
    //size代表约束的最大宽度
    CGSize maxSize  = CGSizeMake(maxW, MAXFLOAT);
    NSLog(@"maxW is %f",maxW);
    CGSize returnSize =  [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:attrs context:nil].size;
    NSLog(@"returnSize is %@",NSStringFromCGSize(returnSize));
    return returnSize;
}

-(void)setStatus:(HWStatus *)status
{
    
    _status  =status;
    HWUser *user = status.user;
    
    CGFloat cellW  =  [UIScreen mainScreen].bounds.size.width;
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

    
//    //来源
//    @property (nonatomic,assign) CGRect sourceLabelFrame;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabelFrame) + HWStatusCellBorderW;
    CGFloat sourceLabelY  = CGRectGetMaxY(self.nameLabelFrame) + HWStatusCellBorderW;
    CGSize sourceLabelSize = [self sizeWithText:status.created_at font:HWStatusCellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //    //正文
    //    @property (nonatomic,assign) CGRect contentLabelFrame;
    CGFloat contentLabelX = iconX;
    CGFloat contentLabelY  = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + HWStatusCellBorderW;;
    CGFloat maxW   =  cellW - 2 * contentLabelX;
    CGSize contentLabelSize = [self sizeWithText:status.created_at font:HWStatusCellContentFont maxW:maxW];
    NSLog(@"%@",NSStringFromCGSize(contentLabelSize));
    self.contentLabelFrame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    CGFloat orgingalH;
    //    //配图
    //    @property (nonatomic,assign) CGRect photoViewFrame;
    if (status.pic_urls.count ) {//有配图
        CGFloat photoWH = 100;
        CGFloat photoX = HWStatusCellBorderW;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + HWStatusCellBorderW;
        self.photoViewFrame = CGRectMake(photoX, photoY, photoWH, photoWH);
        
         orgingalH  =  CGRectGetMaxY(self.photoViewFrame) + HWStatusCellBorderW;
    }
    else{//没有配图
         orgingalH  =  CGRectGetMaxY(self.contentLabelFrame) + HWStatusCellBorderW;
    }

//    @property (nonatomic,assign) CGFloat cellHeight;
//    //原创微博整体
//    @property (nonatomic,assign) CGRect originalViewFrame;
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW  = cellW;
   
    self.originalViewFrame  = CGRectMake(originalX, originalY, originalW, orgingalH);
    
    self.cellHeight = CGRectGetMaxY(self.originalViewFrame);
}
@end

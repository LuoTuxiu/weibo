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
#import "NSString+Extension.h"
#import "HWStatusPhotosView.h"
@implementation HWStautsFrame


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
    CGSize nameSize = [user.name sizeWithTextfont:HWStatusCellNameFont];
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
    CGSize timeSize = [status.created_at sizeWithTextfont:HWStatusCellTimeFont];
    self.timeLabelFrame = (CGRect){{timeX,timeY},timeSize};

    
//    //来源
//    @property (nonatomic,assign) CGRect sourceLabelFrame;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabelFrame) + HWStatusCellBorderW;
    CGFloat sourceLabelY  = CGRectGetMaxY(self.nameLabelFrame) + HWStatusCellBorderW;
    CGSize sourceLabelSize = [status.source sizeWithTextfont:HWStatusCellSourceFont];
    self.sourceLabelFrame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //    //正文
    //    @property (nonatomic,assign) CGRect contentLabelFrame;
    CGFloat contentLabelX = iconX;
    CGFloat contentLabelY  = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + HWStatusCellBorderW;;
    CGFloat maxW   =  cellW - 2 * contentLabelX;
//    NSLog(@"%@",status.created_at);

    CGSize contentLabelSize = [status.text sizeWithfont:HWStatusCellContentFont maxW:maxW];
//    CGSize contentLabelSize = CGSizeMake(320, 200);
//    NSLog(@"%@",NSStringFromCGSize(contentLabelSize));
    self.contentLabelFrame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    
    CGFloat orgingalH;
    //    //配图
    //    @property (nonatomic,assign) CGRect photoViewFrame;
    if (status.pic_urls.count ) {//有配图
//        CGFloat photoWH = 100;
        CGFloat photoX = HWStatusCellBorderW;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelFrame) + HWStatusCellBorderW;
        CGSize photoSize = [HWStatusPhotosView photoSizeWithCount:(int)status.pic_urls.count];
        self.photoViewFrame = (CGRect){{photoX,photoY},photoSize};
        
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
    
    CGFloat toolBarY = 0;
    //被转发微博
    if (status.retweeted_status) {
        HWStatus *retweeted_status =  status.retweeted_status;
        HWUser *retweeted_user  = retweeted_status.user;
        NSString *retweetContent  = [ NSString stringWithFormat:@"@%@ : %@",retweeted_user.name,retweeted_status.text];

        //正文
        CGFloat retweetlabelX  = HWStatusCellBorderW;
        CGFloat retweetlabelY = HWStatusCellBorderW;
        CGSize contentLabelSize = [retweeted_status.text sizeWithfont:HWStatusCellretweetContentFont maxW:maxW];
        self.retweetlLabelFrame = (CGRect){{retweetlabelX,retweetlabelY},contentLabelSize};
        //配图
        if (retweeted_status.pic_urls.count) {
//            CGFloat retweetphotoWH = 100;
            CGFloat retweetphotoX = retweetlabelX;
            CGFloat retweetphotoY = CGRectGetMaxY(self.retweetlLabelFrame) + HWStatusCellBorderW;
            CGSize retweetPhotoSize = [HWStatusPhotosView photoSizeWithCount:(int)retweeted_status.pic_urls.count];
            self.retweetlphotoViewFrame = (CGRect){{retweetphotoX,retweetphotoY},retweetPhotoSize};


        }
        
        
        //转发整体
        CGFloat retweetX = 0;
        CGFloat retWeetY = CGRectGetMaxY(self.originalViewFrame) ;
        CGFloat retWeetW  =  cellW;
//        NSLog(@"retweeted_status.pic_urls.count %lu",(unsigned long)retweeted_status.pic_urls.count);
//        NSLog(@"%@,, %@",NSStringFromCGRect(self.retweetlphotoViewFrame),NSStringFromCGRect(self.retweetlLabelFrame));
        CGFloat retWeetH  = (retweeted_status.pic_urls.count?CGRectGetMaxY(self.retweetlphotoViewFrame):CGRectGetMaxY(self.retweetlLabelFrame))  +  HWStatusCellBorderW;
//        NSLog(@"%f",retWeetH);
        self.retweetlViewFrame = CGRectMake(retweetX, retWeetY, retWeetW, retWeetH );
//        self.cellHeight = CGRectGetMaxY(self.retweetlViewFrame);
        toolBarY = CGRectGetMaxY(self.retweetlViewFrame);
    }
    else
    {
//        self.cellHeight = CGRectGetMaxY(self.originalViewFrame);
        toolBarY = CGRectGetMaxY(self.originalViewFrame) ;


    }
    
    
    //工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW  = cellW;
    CGFloat toolBarH  = 35;
    self.toolBarViewFrame  = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarViewFrame) + HWStatusCellBorderH;

    
    
    
    }
@end

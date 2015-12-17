//
//  HWStatusCell.m
//  myweibo
//
//  Created by 徐磊 on 15/12/16.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStautsFrame.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"
#import "HWPhotos.h"
@interface HWStatusCell()

//原创微博整体
@property (nonatomic,weak) UIView *originalView;
//头像
@property (nonatomic,weak) UIImageView *iconView;
//配图
@property (nonatomic,weak) UIImageView *photoView;
//会员图标
@property (nonatomic,weak) UIImageView *vipView;
//名称
@property (nonatomic,weak) UILabel *nameLabel;
//时间
@property (nonatomic,weak) UILabel *timeLabel;
//正文
@property (nonatomic,weak) UILabel *contentLabel;
//来源
@property (nonatomic,weak) UILabel *sourceLabel;
@end
@implementation HWStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//cell的初始化方法，一个cell只会调用一次
//一般在这里设置所有可能显示的子空间，以及子控件的一次性设置
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //1.原创微博整体
        //原创微博整体
//        @property (nonatomic,weak) UIView *originalView;
        UIView *orginalView = [[UIView alloc]init];
//        orginalView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:orginalView];
        self.originalView=orginalView;
//        //头像
//        @property (nonatomic,weak) UIImageView *iconView;
        UIImageView *iconView = [[UIImageView alloc]init];
        [orginalView addSubview:iconView];
        self.iconView=iconView;
//        //配图
//        @property (nonatomic,weak) UIImageView *photoView;
        UIImageView *photoView = [[UIImageView alloc]init];
        [orginalView addSubview:photoView];
        self.photoView=photoView;
//        //会员图标
//        @property (nonatomic,weak) UIImageView *vipView;
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [orginalView addSubview:vipView];
        self.vipView=vipView;
//        //名称
//        @property (nonatomic,weak) UILabel *nameLabel;
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setFont:HWStatusCellNameFont];
        [orginalView addSubview:nameLabel];
        self.nameLabel=nameLabel;
//        //时间
//        @property (nonatomic,weak) UILabel *timeLabel;
        UILabel *timeLabel = [[UILabel alloc]init];
        [timeLabel setFont:HWStatusCellTimeFont];
        [orginalView addSubview:timeLabel];
        self.timeLabel=timeLabel;

//        //来源
//        @property (nonatomic,weak) UILabel *sourceLabel;
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = HWStatusCellSourceFont;
        [orginalView addSubview:sourceLabel];
        self.sourceLabel=sourceLabel;
        
        //        //正文
        //        @property (nonatomic,weak) UILabel *contentLabel;
        UILabel *contentLabel = [[UILabel alloc]init];
        [contentLabel setFont:HWStatusCellContentFont];
        
        [orginalView addSubview:contentLabel];
        contentLabel.numberOfLines = 0;
        self.contentLabel=contentLabel;
    }
    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID =  @"statuses";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =  [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setStatusFrame:(HWStautsFrame *)statusFrame
{
    _statusFrame  = statusFrame;
    HWStatus *status  = statusFrame.status;
    HWUser *user  = status.user;
    
    //原创微博整体

    self.originalView.frame = statusFrame.originalViewFrame;
    //        //头像
    //        @property (nonatomic,weak) UIImageView *iconView;

    self.iconView.frame=statusFrame.iconViewFrame;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //        //配图
    //        @property (nonatomic,weak) UIImageView *photoView;
//    UIImageView *photoView = [[UIImageView alloc]init];
//    [orginalView addSubview:photoView];
    self.photoView.frame=statusFrame.photoViewFrame;
//    self.photoView.backgroundColor = [UIColor blueColor];
    if (status.pic_urls.count) {
        HWPhotos *photo = [status.pic_urls firstObject];
            [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden= NO;
    }
    else
    {
        self.photoView.hidden = YES;
    }

//    //        //会员图标
//    //        @property (nonatomic,weak) UIImageView *vipView;
//    UIImageView *vipView = [[UIImageView alloc]init];
//    [orginalView addSubview:vipView];
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame=statusFrame.vipViewFrame;
        NSString *vipname  =  [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipname];
        self.nameLabel.textColor  = [UIColor orangeColor];
    }
    else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor  = [UIColor blackColor];
    }
//    //        //名称
//    //        @property (nonatomic,weak) UILabel *nameLabel;
//    UILabel *nameLabel = [[UILabel alloc]init];
//    [orginalView addSubview:nameLabel];
    self.nameLabel.frame =statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
//    //        //时间
//    //        @property (nonatomic,weak) UILabel *timeLabel;
//    UILabel *timeLabel = [[UILabel alloc]init];
//    [orginalView addSubview:timeLabel];
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame=statusFrame.timeLabelFrame;
//    //        //正文
//    //        @property (nonatomic,weak) UILabel *contentLabel;
//    UILabel *contentLabel = [[UILabel alloc]init];
//    [orginalView addSubview:contentLabel];
//    self.contentLabel=contentLabel;
    self.contentLabel.text = status.text;
//    NSLog(@"%@",status.text);
    self.contentLabel.frame=statusFrame.contentLabelFrame;
//    NSLog(@"%@",NSStringFromCGRect(self.contentLabel.frame));
//    //        //来源
//    //        @property (nonatomic,weak) UILabel *sourceLabel;
//    UILabel *sourceLabel = [[UILabel alloc]init];
//    [orginalView addSubview:sourceLabel];
    self.sourceLabel.text = status.source;
    
    self.sourceLabel.frame  =statusFrame.sourceLabelFrame;
}

@end

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
#import "HWStatusToolBar.h"
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

//转发微博整体
@property (nonatomic,weak) UIView *retweetlView;
//转发微博正文+ 昵称
@property (nonatomic,weak) UILabel *retweetlLabel;
//配图
@property (nonatomic,weak) UIImageView *retweetlphotoView;

//工具条
@property (nonatomic,weak) HWStatusToolBar *toolBarView;
////转发微博正文+ 昵称
//@property (nonatomic,weak) UILabel *retweetlLabel;
////配图
//@property (nonatomic,weak) UIImageView *retweetlphotoView;

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        UIView *bg  = [[UIView alloc]init];
//        bg.backgroundColor = [UIColor redColor];
//        self.selectedBackgroundView = bg;
        self.backgroundColor = [UIColor clearColor];
     //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupretweet];
        
        //初始化工具条
        [self setupToolBar];
    }
    return self;
}

-(void)setupOriginal
{
    //1.原创微博整体
    //原创微博整体
    //        @property (nonatomic,weak) UIView *originalView;
    UIView *orginalView = [[UIView alloc]init];
            orginalView.backgroundColor = [UIColor whiteColor];
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


//转发微博
-(void)setupretweet
{
    //原创微博整体
    //        @property (nonatomic,weak) UIView *originalView;
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:retweetView];
    self.retweetlView=retweetView;
    
    //        //配图
    //        @property (nonatomic,weak) UIImageView *photoView;
    UIImageView *retweetphotoView = [[UIImageView alloc]init];
    [self.retweetlView addSubview:retweetphotoView];
    self.retweetlphotoView=retweetphotoView;
    
    //        //正文
    //        @property (nonatomic,weak) UILabel *contentLabel;
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [retweetContentLabel setFont:HWStatusCellretweetContentFont];
    
    [self.retweetlView addSubview:retweetContentLabel];
    retweetContentLabel.numberOfLines = 0;
    self.retweetlLabel=retweetContentLabel;
}

-(void)setupToolBar
{
    HWStatusToolBar *toolbar = [HWStatusToolBar toolBar];
//    toolbar.backgroundColor  = [UIColor yellowColor];
    [self.contentView addSubview:toolbar];
    self.toolBarView = toolbar;
    
    
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
    
    
    //转发微博
    if (status.retweeted_status) {
        //整体

        HWStatus *retweeted_status = status.retweeted_status;;
        HWUser *retweeted_status_user = retweeted_status.user;
        self.retweetlView.hidden  = NO;
        
                self.retweetlView.frame =  statusFrame.retweetlViewFrame;

        
        //    //        //正文
        //    //        @property (nonatomic,weak) UILabel *contentLabel;
        //    UILabel *contentLabel = [[UILabel alloc]init];
        //    [orginalView addSubview:contentLabel];
        //    self.contentLabel=contentLabel;
        NSString *retweetContent  = [ NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        NSLog(@"%@",retweetContent);
        self.retweetlLabel.text = retweetContent;
        //    NSLog(@"%@",status.text);
        self.retweetlLabel.frame=statusFrame.retweetlLabelFrame;
        
        
        //        //配图
        //        @property (nonatomic,weak) UIImageView *photoView;
        //    UIImageView *photoView = [[UIImageView alloc]init];
        //    [orginalView addSubview:photoView];

        //    self.photoView.backgroundColor = [UIColor blueColor];
        if (retweeted_status.pic_urls.count) {
            self.retweetlphotoView.frame=statusFrame.retweetlphotoViewFrame;
            HWPhotos *retweetphoto = [retweeted_status.pic_urls firstObject];
            [self.retweetlphotoView sd_setImageWithURL:[NSURL URLWithString:retweetphoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetlphotoView.hidden= NO;
        }
        else
        {
            self.retweetlphotoView.hidden = YES;
        }
        
    }else
    {
        self.retweetlView.hidden = YES;
    }
    
    
    //工具条
    self.toolBarView.frame = statusFrame.toolBarViewFrame;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += HWStatusCellBorderH;
    [super setFrame: frame];
    
}
@end

//
//  HWStatusSinglePhotoView.m
//  myweibo
//
//  Created by 徐磊 on 15/12/24.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatusSinglePhotoView.h"
#import "HWPhotos.h"
@interface HWStatusSinglePhotoView()
@property (nonatomic,weak) UIImageView *gitView;
@end
@implementation HWStatusSinglePhotoView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //这样子写可以保证UIImageView的尺寸和图片尺寸一样
        UIImageView *gitView  =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gitView];
        _gitView = gitView;
//        gitView.image  = [UIImage imageNamed:]
    }
    return self;
}


-(void)setPhoto:(HWPhotos *)photo
{
    _photo  = photo;

  [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //判断后缀
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gitView.hidden = NO;
//    }
//    else
//    {
//        self.gitView.hidden = YES;
//    }
    //lowercaseString将字符串变成小写
    self.gitView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
//    [photo.thum]
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gitView.x = self.width - self.gitView.width ;
    self.gitView.y = self.height - self.gitView.height;
}

@end

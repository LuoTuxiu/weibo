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
        
//        UIViewContentModeScaleToFill,//填充，将图片拉伸充满整个uiiamgeview
//        UIViewContentModeScaleAspectFit,      //保持图片宽高比进行拉伸到宽或者高直到图片完全在里面 contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // 保持图片宽高比进行起码拉伸到宽或者高contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              //调用setNeedsDisplay时候重画 redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              //居中显示，不会拉伸 contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
        //1.凡是带有Scale都会拉伸；
//        2.凡是带有Aspect都会按照图片原来的宽高比；也就是图片不会变形；
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框的内容就剪切掉
        self.clipsToBounds = YES;
        
        
        self.backgroundColor = [UIColor redColor];
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

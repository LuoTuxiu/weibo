//
//  HWStatusPhotosView.m
//  myweibo
//
//  Created by 徐磊 on 15/12/23.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhotos.h"
#import "UIImageView+WebCache.h"
#import "HWStatusSinglePhotoView.h"
#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) (((count)==4)?2:3)
@implementation HWStatusPhotosView

-(void)setPhotos:(NSArray *)photos
{
    _photos  = photos;
    int photoCount   = (int)photos.count;
    //让所有的子控件执行某句函数
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //创建足够数量的imageview
//    NSLog(@"%lu",(unsigned long)photos.count);
//    if (self.subviews.count >= photos.count) {//内部的imageview是够用的
//        
//    }
//    else//内部的imageview不够用
//    {
        //创建缺少的imageview
        while (self.subviews.count  <  photos.count) {
            HWStatusSinglePhotoView *photoView = [[HWStatusSinglePhotoView alloc]init];
            [self addSubview:photoView];
        }
//    }
    
    //遍历图片控件
    for (int i = 0; i<self.subviews.count; i++) {
        HWStatusSinglePhotoView *photoView = self.subviews[i];
        
        //photo.count = 3
        if (i < photoCount) {
            //显示
            
            photoView.photo= photos[i];
            photoView.hidden = NO;
//            [photoView sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            //隐藏
            photoView.hidden = YES;
        }
    }
}

//在这里面设置尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片的尺寸和位置
        int photoCount   = (int)self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photoCount);

    for (int i = 0; i<photoCount; i++) {
                HWStatusSinglePhotoView *photoView = self.subviews[i];
        
        int col   = i % maxCol;
        int raw  = i / maxCol;
       photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
       photoView.y = raw * (HWStatusPhotoWH + HWStatusPhotoMargin);
       photoView.width = HWStatusPhotoWH;
       photoView.height = HWStatusPhotoWH;

    }
}


+(CGSize)photoSizeWithCount:(int)count
{
    int maxCol = HWStatusPhotoMaxCol(count);
    //计算列数
    int cols = count > 2 ?maxCol:count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    //行数
    int rows = count % 3? count / 3 + 1:count / 3 ;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
}
@end

//
//  HWComposePhotoView.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWComposePhotoView.h"
@interface HWComposePhotoView()
@property ( nonatomic ,strong) NSMutableArray *addedPhotos;
@end
@implementation HWComposePhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)addedPhotos
{
    if (!_addedPhotos) {
        _addedPhotos = [NSMutableArray array];
    }
    
    return _addedPhotos;
}


-(void)addPhoto:(UIImage *)photo
{
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image  = photo;
    [self.addedPhotos addObject:imageView];
        [self addSubview:imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    int photoCount   = (int)self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH  = 70;
    CGFloat imageMarging = 10;
    for (int i = 0; i<photoCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col   = i % maxCol;
        int raw  = i / maxCol;
        photoView.x = col * (imageWH + imageMarging);
        photoView.y = raw * (imageWH + imageMarging);
        photoView.width = imageWH;
        photoView.height = imageWH;
        
    }
}

-(NSArray *)photo
{
//    NSMutableArray *array = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        []
//    }
    return self.addedPhotos;
}
@end

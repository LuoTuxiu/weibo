//
//  HWComposePhotoView.h
//  myweibo
//
//  Created by LuoTuxiu on 15/12/30.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWComposePhotoView : UIView
@property ( nonatomic ,strong,readonly) NSMutableArray *addedPhotos;
-(void)addPhoto:(UIImage *)photo;
//@property ( nonatomic ,strong) NSArray *photo;
//定义属性为readonly时，如果又自己手动生成了getter方法，则成员变量不会自动生成，如果没有手动生成getter方法，成员变量还是有的；
//如果手动实现了setter和getter，那么就不会自动生成setter，getter和下划线成员变量了；
//-(NSArray *)photo;
@end

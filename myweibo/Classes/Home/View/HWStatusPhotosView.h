//
//  HWStatusPhotosView.h
//  myweibo
//
//  Created by 徐磊 on 15/12/23.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView
@property (nonatomic,strong) NSArray *photos;
+(CGSize)photoSizeWithCount:(int)count;
@end

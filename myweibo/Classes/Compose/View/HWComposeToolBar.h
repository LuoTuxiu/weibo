//
//  HWComposeToolBar.h
//  myweibo
//
//  Created by LuoTuxiu on 15/12/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HWComposeToolBarButtonTypeCamera,//拍照
    HWComposeToolBarButtonTypeAlbums,
    HWComposeToolBarButtonTypeMention,
    HWComposeToolBarButtonTypeTrend,
    HWComposeToolBarButtonTypeEmotion,
} HWComposeToolBarButtonType;

@class HWComposeToolBar;
@protocol HWComposeToolBarDelegate <NSObject>
@optional
-(void)composeToolBar:(HWComposeToolBar *)toolBar didClickButton:(HWComposeToolBarButtonType)type;
@end


@interface HWComposeToolBar : UIView
@property (weak, nonatomic) id<HWComposeToolBarDelegate> delegate;
@end

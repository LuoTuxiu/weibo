//
//  HWStatusToolBar.h
//  myweibo
//
//  Created by LuoTuxiu on 15/12/19.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus;
@interface HWStatusToolBar : UIView
+(instancetype)toolBar;
@property ( nonatomic ,strong) HWStatus *status;

@end

//
//  HWTextView.h
//  myweibo
//
//  Created by LuoTuxiu on 15/12/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWTextView : UITextView
//占位文字
@property (nonatomic,copy) NSString * placeholderText;
//占位文字的颜色
@property ( nonatomic ,strong) UIColor *placeholderColor;
@end

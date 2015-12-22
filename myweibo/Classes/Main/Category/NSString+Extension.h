//
//  NSString+Extension.h
//  myweibo
//
//  Created by 徐磊 on 15/12/22.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
-(CGSize)sizeWithTextfont:(UIFont *)font;
-(CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW;
@end

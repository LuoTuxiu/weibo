//
//  NSString+Extension.m
//  myweibo
//
//  Created by 徐磊 on 15/12/22.
//  Copyright © 2015年 test. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithTextfont:(UIFont *)font
{
    return [self sizeWithfont:font maxW:MAXFLOAT];
    
}
//根据最大宽度来算frame
-(CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs  = [NSMutableDictionary dictionary];
    //    attrs[NSForegroundColorAttributeName]= [UIColor blackColor];
    attrs[NSFontAttributeName] = font;
    //    NSLog(@"%@",font);
    //    return [text sizeWithAttributes:attrs];
    //size代表约束的最大宽度
    CGSize maxSize  = CGSizeMake(maxW, MAXFLOAT);
    //    NSLog(@"maxW is %f",maxW);
    CGSize returnSize =  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:attrs context:nil].size;
    //    NSLog(@"returnSize is %@",NSStringFromCGSize(returnSize));
    return returnSize;
}

@end

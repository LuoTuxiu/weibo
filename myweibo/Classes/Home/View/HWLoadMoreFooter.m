//
//  HWLoadMoreFooter.m
//  myweibo
//
//  Created by 徐磊 on 15/12/15.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil] firstObject];
}
@end

//
//  itemTool.h
//  微博大项目
//
//  Created by 徐磊 on 15/9/20.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itemTool : NSObject

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end

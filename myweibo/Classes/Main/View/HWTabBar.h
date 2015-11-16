//
//  HWTabBar.h
//  myweibo
//
//  Created by xulei on 15/10/28.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>



@class HWTabBar;
#warning 要遵循父类的代理，要不然会有警告,因为会有重复
@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end



@interface HWTabBar : UITabBar
@property (nonatomic,weak) id<HWTabBarDelegate> delegate;
@end

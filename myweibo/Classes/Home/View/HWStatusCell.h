//
//  HWStatusCell.h
//  myweibo
//
//  Created by 徐磊 on 15/12/16.
//  Copyright © 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStautsFrame;
@interface HWStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) HWStautsFrame *statusFrame;
@end

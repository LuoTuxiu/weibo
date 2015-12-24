//
//  HWIconView.m
//  myweibo
//
//  Created by 徐磊 on 15/12/24.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"
@interface HWIconView()
@property (nonatomic,weak) UIImageView *verifiledView;
@end
@implementation HWIconView
-(UIImageView *)verifiledView
{
    if (_verifiledView == nil) {
        UIImageView *verifiledView = [[UIImageView alloc]init];
        [self addSubview:verifiledView];
        _verifiledView  = verifiledView;
    }
    return _verifiledView;
}
-(void)setUser:(HWUser *)user
{
    _user = user;
    
    //1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //2.加v
//    hwuserVerifiedTypeNone = -1,//没人任何资格
//    hwuserVerifiedOrgEnterprice = 2,//没人任何资格
//    hwuserVerifiedTypeOrgMedia = 3,//没人任何资格
//    hwuserVerifiedPersonal = 0,//没人任何资格
//    hwuserVerifiedWebsite = 5,//
//    hwuserVerifiedDaren = 220 //微博达人
    switch (user.verified_type) {
        case hwuserVerifiedTypeNone:
            self.verifiledView.hidden = YES;
            break;
        case hwuserVerifiedPersonal:
            self.verifiledView.hidden = NO;
            self.verifiledView.image =  [UIImage imageNamed:@"avatar_vip"];
            break;
        case hwuserVerifiedDaren:
            self.verifiledView.hidden = NO;
            self.verifiledView.image =  [UIImage imageNamed:@"avatar_vip"];
            break;
        case hwuserVerifiedWebsite:
        case hwuserVerifiedOrgEnterprice:
        case hwuserVerifiedTypeOrgMedia:
            self.verifiledView.hidden = NO;
            self.verifiledView.image =  [UIImage imageNamed:@"avatar_vip"];
            break;
        default:
            self.verifiledView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiledView.size =  self.verifiledView.image.size;
    self.verifiledView.x  =  self.width  - self.verifiledView.width;
    self.verifiledView.y = self.height  - self.verifiledView.height;
}
@end

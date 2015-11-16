//
//  HWSearchBar.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/27.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置搜索框的字体大小
        self.font =  [UIFont systemFontOfSize:10];
        self.placeholder =  @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *searchIcon =  [[UIImageView alloc]init];
        searchIcon.image =  [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width =  30;
        searchIcon.height = 30;
        
        //设置下面居中则图片不会被拉伸,是居中的
        searchIcon.contentMode = UIViewContentModeCenter;
        
        //    [searchBar addSubview:searchIcon];
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)seachBar
{
    return [[self alloc]init];
}

@end

//
//  HMMessageTableViewController.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/26.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HMMessageTableViewController.h"
#import "HWTestViewController.h"
@interface HMMessageTableViewController ()

@end

@implementation HMMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //style:这个参数是用来设置背景的，在iOS7以前效果比较明显，ios7没有任何效果
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem.enabled =  NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID =  @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // Configure the cell...
    cell.textLabel.text =  [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWTestViewController *test1 =  [[HWTestViewController alloc]init];
    test1.title  = @"测试1";
    //当push过去的时候，自动隐藏tabbar
    //当test1被pop时，test1的tabbar会自动显示
//    NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
}
@end

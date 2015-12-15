//
//  HMHomeTableViewController.m
//  微博大项目2
//
//  Created by 徐磊 on 15/10/26.
//  Copyright © 2015年 Trbocare. All rights reserved.
//

#import "HMHomeTableViewController.h"
#import "HWDropDownMenu.h"
#import "HWTitleTableViewController.h"
#import "AFNetworking.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "HWTitleButton.h"
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "MJExtension.h"
#import "HWLoadMoreFooter.h"
@interface HMHomeTableViewController ()<HWDropDownMenuDelegate>
/**  微博数组，里面放得是模型，一个模型就代表一条微博*/
@property (nonatomic,strong) NSMutableArray *statues;
@end

@implementation HMHomeTableViewController

-(NSMutableArray *)statues
{
    if (!_statues) {
        _statues = [[NSMutableArray alloc]init];
    }
    return _statues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //设置导航栏内容
    [self setupNav];
    
    //获取用户信息
    [self getUserInfo];

//    //加载最新的微博数据
//    [self loadNewData];
    
    //集成下拉刷新控件
    [self setupRefresh];
    
//    集成上拉刷新
    [self setupUpRefresh];
    
    //获取未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setupUnreadCounr) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)setupUnreadCounr
{
    NSLog(@"%s", __func__);
}

-(void)setupNav
{
    //设置左边的返回按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    //中间标题按钮
    HWTitleButton *titleBtn =  [HWTitleButton buttonWithType:UIButtonTypeCustom];
    //UIButtonTypeCustom相当于alloc、init
    titleBtn.width  = 150;
    titleBtn.height  = 30;
    //    titleBtn.backgroundColor  =  HWRandColor;
    
    //设置按钮文字
    NSString *name = [HWAccountTool account].name;
    
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];

//    //如果文字是固定长度的，则建议使用下列方法来设置间距比较简单；
//    NSMutableDictionary *arrtrs =  [NSMutableDictionary dictionary];
//    arrtrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
//    CGFloat titleW = [titleBtn.currentTitle sizeWithAttributes:arrtrs].width ;
////    CGFloat titleW =  titleBtn.titleLabel.width * [UIScreen mainScreen].scale;
//    //乘上缩放指数，则适配是否是retana屏幕
//    CGFloat imageW = titleBtn.imageView.width * [UIScreen mainScreen].scale;
//    CGFloat left  = titleW + imageW  + 10;
//    //imageEdgeInset只支持像素，其它支持点数
//    titleBtn.imageEdgeInsets  = UIEdgeInsetsMake(0, left, 0, 0);
////    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //如果
    self.navigationItem.titleView = titleBtn;
}

//获取用户信息
-(void)getUserInfo
{
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
    
    
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
    
    //2.拼接请求参数
    HWAccount *acount = [HWAccountTool account];
    NSMutableDictionary *params =  [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
    params[@"uid"] = acount.uid;
    
    //3.发送请求对象，只能是get请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
//        NSLog(@"请求成功%@",responseObject);
        
        //取出responseObject名称
//        NSString *name =  responseObject[@"name"];
//        UIButton *titleButton =  (UIButton *)self.navigationItem.titleView;
//        [titleButton setTitle:name forState:UIControlStateNormal];
        
        HWUser *user = [HWUser objectWithKeyValues:responseObject];
        UIButton *titleButton =  (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        //存储昵称到沙盒中
        acount.name = user.name;
        [HWAccountTool saveAccount:acount];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];

}


-(void)loadNewData
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
    
    
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
    
    //2.拼接请求参数
    HWAccount *acount = [HWAccountTool account];
    NSMutableDictionary *params =  [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
//    params[@"count"] = @1;
    //3.发送请求对象，只能是get请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        NSLog(@"请求成功%@",responseObject);
//        //取得微博数组
//        NSArray *dictArray  = responseObject[@"statuses"];
//        
//        //将"微博的字典数组"转为"微博模型数组"
//        for (NSDictionary *dict in dictArray) {
//            HWStatus *status  = [HWStatus objectWithKeyValues:dict];
//            [self.statues addObject:status];
//        }
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        self.statues = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //self.statues == @[]
        //newStatuses == @[status01,status02]
        [self.statues addObjectsFromArray:newStatuses];
        //self.statues = @[status01,status02]
//        [self.statues addObject:newStatuses];
        //self.statues = @[@[status01,status02]]
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}


-(void)setupRefresh
{
    UIRefreshControl *control =  [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    [control beginRefreshing];
    //2.手动刷新一次
    [self refreshStateChange:control];
}


-(void)setupUpRefresh
{
    HWLoadMoreFooter *footer  = [HWLoadMoreFooter footer];
    self.tableView.tableFooterView   = footer;
}

-(void)refreshStateChange:(UIRefreshControl *)control
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
    
    
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
    
    //2.拼接请求参数
    HWAccount *acount = [HWAccountTool account];
    NSMutableDictionary *params =  [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
    HWStatus *firstStatus = [self.statues firstObject];
    //添加这个属性，则可以加载在这个idstr以后的微博，即只是返回需要更新的微博
    if (firstStatus) {
            params[@"since_id"] = firstStatus.idstr;
    }

    //    params[@"count"] = @1;
    //3.发送请求对象，只能是get请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        NSLog(@"请求成功%@",responseObject);
        //        //取得微博数组
        //        NSArray *dictArray  = responseObject[@"statuses"];
        //
        //        //将"微博的字典数组"转为"微博模型数组"
        //        for (NSDictionary *dict in dictArray) {
        //            HWStatus *status  = [HWStatus objectWithKeyValues:dict];
        //            [self.statues addObject:status];
        //        }
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //将最新的数据加载到数组的最前端
        //        self.statues = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //self.statues == @[]
        //newStatuses == @[status01,status02]
//        [self.statues addObjectsFromArray:newStatuses];
        //self.statues = @[status01,status02]
        //        [self.statues addObject:newStatuses];
        //self.statues = @[@[status01,status02]]
        NSRange range =  NSMakeRange(0, newStatuses.count);
        NSIndexSet *set =  [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statues insertObjects:newStatuses atIndexes:set];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示最新微博数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
        //结束刷新
        [control endRefreshing];
    }];
    

}

-(void)showNewStatusCount:(int)count
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
    //创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width =  [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - 35;
    label.textAlignment = NSTextAlignmentCenter;
    //2.设置其它属性
    if (count == 0) {
        label.text = @"没有新的微博数据";
    }
    else
    {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    
    label.textColor = [UIColor whiteColor];
    
    //3.添加到view
//    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.添加动画
    CGFloat duration  = 1.0;
    [UIView animateWithDuration:duration animations:^{
//        方法1：
//        label.y += label.height;
//        方法2：
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //延时执行动画
        CGFloat delaytime = 1.0;
        [UIView animateWithDuration:duration delay:delaytime options:UIViewAnimationOptionCurveLinear animations:^{
//            方法1
//            label.y -= label.height;
//            方法2:回到原来的样子：如果有这种动画需求则可以用这个比较方便
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

-(void)titleClick:(UIButton *)titleButton
{
    //创建下拉菜单
    HWDropDownMenu *menu  =  [HWDropDownMenu menu];
    menu.delegate = self;
    //    menu.content  =  [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    menu.content  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    HWTitleTableViewController *vc  =  [[HWTitleTableViewController alloc]init];
    vc.view.height =150;
    vc.view.width  =150;
    menu.contentController = vc;
    [menu showFrom:titleButton];
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
//    [menu dismiss];
//    NSLog(@"%s", __func__);
//    
//    //添加蒙板
//    //下面一行的代码可以获得一个窗口，但是如果考虑到多个窗口，则可能出错
//    //    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
//    //如果有多个窗口，则要用下面代码才能够保证显示在最上面的窗口
//    UIWindow *window  = [[UIApplication sharedApplication].windows lastObject];
//    UIView *cover = [[UIView alloc]init];
//    cover.backgroundColor =  [UIColor clearColor];
//    cover.frame  =  window.bounds;
//    
//    [window addSubview:cover];
//    
//    
//    
//    UIImageView *dropDownMenu = [[UIImageView alloc]init];
//    
//    dropDownMenu.image =  [UIImage imageNamed:@"popover_background"];
//    
//    dropDownMenu.width  = 217;
//    dropDownMenu.height  = 300;
//    dropDownMenu.userInteractionEnabled = YES;
//    [window addSubview:dropDownMenu];
//    //self.view.window == [UIApplication shareApplication].keyWindow
//    //建议使用[UIApplication shareApplication].keyWindow，因为self.view.window可能没值
    

    
    
}


-(void)friendsearch
{
    NSLog(@"%s", __func__);
}

-(void)pop
{
    NSLog(@"%s", __func__);
}



#pragma mark 实现代理方法
-(void)DropDownMenuDidMiss:(HWDropDownMenu *)menu
{
    UIButton *titleBtn =  (UIButton*)self.navigationItem.titleView;
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statues.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID =  @"statuses";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // Configure the cell...
    
    //字典取出的方法
//    //取出这行对应的微博字典
//    NSDictionary *status =  self.statues[indexPath.row];
//    
//    //取出这条微博的作者
//    NSDictionary *user =  status[@"user"];
//    cell.textLabel.text = user[@"name"];
//    
//    cell.detailTextLabel.text =   status[@"text"];
//    
//    //设置头像
//    NSString *imageUrl =  user[@"profile_image_url"];
//    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:placehoder];
    
    
    //模型取出的方法：
    HWStatus *status =  self.statues[indexPath.row];
    
    HWUser *user =  status.user;
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text  = status.text;
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    //
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

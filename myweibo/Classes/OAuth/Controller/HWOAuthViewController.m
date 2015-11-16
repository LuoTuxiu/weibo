//
//  HWOAuthViewController.m
//  myweibo
//
//  Created by 徐磊 on 15/10/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建一个webview
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //2.用webview加载登陆界面
    //请求地址：https://api.weibo.com/oauth2/authorize
    //请求参数
    
    NSURL *url = [NSURL URLWithString:@"https://open.weibo.cn/oauth2/authorize?client_id=2432819866&redirect_uri=http://"];
    NSURLRequest *request  = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 实现代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url =  request.URL.absoluteString;
    
    //判断是否为回调地址
    NSRange range =  [url rangeOfString:@"code="];
    
    if (range.length != 0) {    //是回调地址
        //截取code=后面的参数值
        //1.方法1：正则表达式
        //2.方法2：substring
        int fromIndex = range.location + range.length;
        NSString *code =  [url substringFromIndex:fromIndex];
        NSLog(@"%@ ---%@",url,code);
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];

        //禁止加载回调函数,防止意外加载回调地址的网页
        return NO;
    }
    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    []
    [MBProgressHUD showMessage:@"正在登陆中"];
    
}

//加载页面完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
        [MBProgressHUD hideHUD];
}

 //利用code换取一个accessToken
-(void)accessTokenWithCode:(NSString *)code
{
    //        URL：https://api.weibo.com/oauth2/access_token
    //        请求参数：
    //        client_id：申请应用时分配的AppKey
    //        client_secret：申请应用时分配的AppSecret
    //        grant_type：使用authorization_code
    //        redirect_uri：授权成功后的回调地址
    //        code：授权成功后返回的code
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
    
    
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
    
    //2.拼接请求参数
    NSMutableDictionary *params =  [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2432819866";
    params[@"client_secret"] = @"8b4387dd639fe71202ddef47f92fdffe";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] =@"http://";
    params[@"code"] = code;
    
    //3.发送请求对象，只能是post请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        NSLog(@"请求成功%@",responseObject);
        [MBProgressHUD hideHUD];
        

        
        //方法1：将返回的账号字典数据写入文件
//        [responseObject writeToFile:path atomically:YES];
        //方法2：
        HWAccount *account  = [HWAccount acocuntWithDict:responseObject];
        
        //将返回的账号数据存进沙盒
        [HWAccountTool saveAccount:account];
        
        UIWindow *window =  [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];

        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}

@end

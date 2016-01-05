//
//  HWComposeViewController.m
//  myweibo
//
//  Created by LuoTuxiu on 15/12/29.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWTextView.h"
#import "AFNetworking.h"
#import "HWComposeToolBar.h"
#import "HWComposePhotoView.h"
@interface HWComposeViewController ()<UITextViewDelegate,HWComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property ( nonatomic ,weak) HWTextView *textView;
@property (weak, nonatomic) HWComposeToolBar *toolBar;
//存放选择的图片
@property (weak, nonatomic) HWComposePhotoView *photoView;
@end

@implementation HWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    [self setupTextView];
    
    //默认系统会自动根据导航栏来调整高度，默认是yes，当scrollView遇到UINavgationBar和UITabBar时，默认会自动设置scrollView的contentInset
//    self.automaticallyAdjustsScrollViewInsets
    
    [self setupToolBar];
    
    //添加类似九宫格
    [self setupPhotoView];
}



-(void)setupNav
{
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    UILabel *titleView = [[UILabel alloc]init];
    titleView.width = 200;
    titleView.height = 35;
    titleView.numberOfLines = 0;
    
    //    titleView.backgroundColor = [UIColor redColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    NSString *name  = [HWAccountTool account].name;
    if (name) {
        NSString *str = [NSString stringWithFormat:@"发微博\n%@",name];
        //创建一个可装饰的带有属性的字符串（比如文字的属性，颜色等）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        //添加属性
        //boldSystemFontOfSize设置为粗体
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14 ] range:NSMakeRange(0,3)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        //    NSTextAttachment *att = [[NSTextAttachment alloc]init];
        //    att.image = [UIImage imageNamed:@"album"];
        //    [attrStr appendAttributedString:[NSAttributedString attributedStringWithAttachment:att]];
        titleView.attributedText = attrStr;
        
        
        self.navigationItem.titleView  = titleView;
    } else {
        self.title = @"发微博";
    }
}

-(void)setupTextView
{
    
    //UITextField:
    //1.设置代理
    //2.addtaget;
    //3.通知：UITextFieldTextDidChangeNotification
    
    //UITextView
    //1.设置代理，2.通知
    //这个可以显示任意多行,但没有占位文字
    //在这个控制器中，textview的contentInset默认会等于64，而uitextField却是0
    HWTextView *textView = [[HWTextView alloc]init];
    textView.placeholderText = @"分享新鲜事...";
    textView.placeholderColor = [UIColor redColor];
    textView.frame  = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:18];
    textView.delegate = self;
    //在垂直方向上有弹簧效果
    textView.alwaysBounceVertical = YES;
    
    self.textView = textView;
    

    [self.view addSubview:textView];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //键盘通知
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //让textView(能输入文本的控件)成为第一响应者则可以弹出键盘
    [self.textView becomeFirstResponder];
}

-(void)setupToolBar
{
    HWComposeToolBar *toolBar = [[HWComposeToolBar alloc]init];
    toolBar.width = self.view.bounds.size.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    self.toolBar  = toolBar;
    toolBar.delegate =self;
    //用来修改系统键盘
    //设置成键盘
//    self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //设置成键盘上面的view
//    self.textView.inputAccessoryView=toolBar;
    [self.view addSubview:toolBar];
    
}

-(void)setupPhotoView
{
    HWComposePhotoView *photoView =  [[HWComposePhotoView alloc]init];
    photoView.width  = self.view.width;
    photoView.height = 300;
    photoView.y = 100;
//    photoView.backgroundColor = [UIColor redColor];
    [self.textView addSubview:photoView];
    self.photoView = photoView;
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//必选	类型及范围	说明
//source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
//access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
//visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
//list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
//lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
//long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
//annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
//rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
//https://api.weibo.com/2/statuses/update.json
-(void)send
{
    NSLog(@"send");
    if (self.photoView.addedPhotos.count > 0) {
        //1.请求管理者
        AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
        
        
        //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
        
        //2.拼接请求参数
        NSMutableDictionary *params =  [NSMutableDictionary dictionary];
        params[@"access_token"] = [HWAccountTool account].access_token;
        params[@"status"] = self.textView.text;
        
        NSLog(@"%@",self.photoView.addedPhotos);
        //3.发送请求对象，只能是post请求
        //    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
        //                NSLog(@"请求成功%@",responseObject);
        //        [MBProgressHUD showSuccess:@"发送成功"];
        //
        //
        //    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //        NSLog(@"请求失败%@",error);
        //        [MBProgressHUD showError:@"发送失败"];
        //    }];
        
        //3.发送图片的url
        [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImageView *imageView = [self.photoView.addedPhotos firstObject];
//            NSData *data  = UIImageJPEGRepresentation(image, 1.0);
            NSData *data = UIImagePNGRepresentation(imageView.image);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"请求成功%@",responseObject);
            [MBProgressHUD showSuccess:@"发送成功"];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"请求失败%@",error);
            [MBProgressHUD showError:@"发送失败"];
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        //没有图片的发送微博
        //1.请求管理者
        AFHTTPRequestOperationManager *mgr =  [AFHTTPRequestOperationManager manager];
        
        
        //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        //AFN的AFJSONResponseSerializer默认不接受text/plain这种类型，所以我修改了源代码
        
        //2.拼接请求参数
        NSMutableDictionary *params =  [NSMutableDictionary dictionary];
        params[@"access_token"] = [HWAccountTool account].access_token;
        params[@"status"] = self.textView.text;
        
        NSLog(@"%@",self.photoView.addedPhotos);
//        3.发送请求对象，只能是post请求
            [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * responseObject) {
                        NSLog(@"请求成功%@",responseObject);
                [MBProgressHUD showSuccess:@"发送成功"];
        
        
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"请求失败%@",error);
                [MBProgressHUD showError:@"发送失败"];
            }];
        
//        //3.发送图片的url
//        [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            UIImage *image = [self.photoView.addedPhotos firstObject];
//            NSData *data  = UIImageJPEGRepresentation(image, 1.0);
//            [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
//        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSLog(@"请求成功%@",responseObject);
//            [MBProgressHUD showSuccess:@"发送成功"];
//        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//            NSLog(@"请求失败%@",error);
//            [MBProgressHUD showError:@"发送失败"];
//        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
}


-(void)textDidChange
{
    NSLog(@"textDidChange");
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

//键盘发生改变时就调用
-(void)keyboardFrameDidChange:(NSNotification *)notification
{
    //键盘弹出后的frame
//    {name = UIKeyboardDidChangeFrameNotification; userInfo = {
    //键盘弹出或隐藏执行节奏
//        UIKeyboardAnimationCurveUserInfoKey = 7;
//  键盘弹出、隐藏耗费时间
//        UIKeyboardAnimationDurationUserInfoKey = 0;
//        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 282}}";
//        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 460}";
//        UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 427}";
//        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
//        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 286}, {320, 282}}";
//        UIKeyboardIsLocalUserInfoKey = 1;
//    }}
    //字典只能放对象，上面的都是NSValue
//    @{
//      UIKeyboardFrameBeginUserInfoKey :[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]
//      };
    
    NSLog(@"%@",notification);
    NSDictionary *userInfo  = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //取出弹出后的键盘的frame
    CGRect keyBoardF  =  [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.y = keyBoardF.origin.y - self.toolBar.height;
    }];
//    notification
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark  - uitextDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //退出键盘
    [self.view endEditing:YES];
}

#pragma mark ToolBardelegate
-(void)composeToolBar:(HWComposeToolBar *)toolBar didClickButton:(HWComposeToolBarButtonType)type
{
    switch (type) {
        case HWComposeToolBarButtonTypeCamera://拍照
            [self openCamera];
            NSLog(@"拍照");
            break;
        case HWComposeToolBarButtonTypeAlbums://相册
            [self openAlbums];
            NSLog(@"相册");
            break;
        case HWComposeToolBarButtonTypeMention://@
            NSLog(@"@");
            break;
        case HWComposeToolBarButtonTypeTrend://#
            NSLog(@"#");
            break;
        case HWComposeToolBarButtonTypeEmotion://表情
            NSLog(@"表情");
            break;
    }
}

#pragma mark - 其它方法
-(void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbums
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
  
}

-(void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


//拍照后或者选择图片后就调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //info中包含了选择的图片
    NSLog(@"%@",info);
    UIImage *image  =  info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photoView中
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image  = image;
//    [self.photoView addSubview:imageView];
    [self.photoView addPhoto:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

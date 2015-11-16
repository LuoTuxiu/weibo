//
//  HWNewFeatureViewController.m
//  myweibo
//
//  Created by 徐磊 on 15/10/28.
//  Copyright © 2015年 test. All rights reserved.
//

#import "HWNewFeatureViewController.h"
#import "HMMainTabBarController.h"
#define HWNewFeatureCount 4
@interface HWNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation HWNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建一个scrollView:显示所有的新特性的图片
    UIScrollView *scrollView =  [[UIScrollView alloc]init];
    scrollView.frame =  self.view.bounds;

    [self.view addSubview:scrollView];
    
    //2.添加图片到scrollview
    CGFloat scrollW =  scrollView.width;
    CGFloat scrollH =  scrollView.height;
    //for循环只适用于小数据，不然内存会大
    for (int i =0; i< HWNewFeatureCount; i++) {
        UIImageView *imageView  = [[UIImageView alloc]init];

        imageView.width =  scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        NSString *name =  [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        
        //如果是最后一个imageview
        //如果使用lastView取出最后一个图片可能会出错，因为可能scollview里面存在有看不到的view，即系统默认存在的
        if ( i== HWNewFeatureCount - 1) {
            [self settupLastImage:imageView];
        }
    }
    
    //如果想要某个方向上不能滚动，那么这个方向上的尺寸设置为0即可
    scrollView.contentSize =CGSizeMake(HWNewFeatureCount * scrollView.width, 0);
    scrollView.delegate = self;
    //取消弹簧效果
    scrollView.bounces = NO;
    
    //
    scrollView.pagingEnabled = YES;
    
    //取消滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //添加分页page，分页，展示目前看得是第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //一个父控件就算尺寸为0，它的子控件也能够显示的，只要子控件有尺寸，但此时不能够点击，即不能够响应时间
    //UIPageControl比较特殊，就算没有设置尺寸也能够正常显示，但是此时它高度为0，点击时就没效果了
//    pageControl.width  = 100;

//    pageControl.height = 50;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
//    pageControl.backgroundColor = [UIColor redColor];
    pageControl.numberOfPages = HWNewFeatureCount;
    pageControl.pageIndicatorTintColor = HWColor(189, 189, 189);
    pageControl.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    
    //一般都禁止用户交互
//    pageControl.userInteractionEnabled = YES;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//        NSLog(@"%s\n",__func__);
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page =  scrollView.contentOffset.x / scrollView.width;
    
    
    
    //四舍五入计算出页码
    self.pageControl.currentPage =  (int)(page + 0.5);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//初始化最后一个imageview
-(void)settupLastImage:(UIImageView *)imageView
{
    imageView.userInteractionEnabled  = YES;
    //分享给大家checkbox
    UIButton *shareBtn  = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];

    shareBtn.width =  100;
    shareBtn.height = 30;
    shareBtn.centerX =  imageView.width  * 0.5;
    shareBtn.centerY =  imageView.height * 0.65;
    
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font  =  [UIFont systemFontOfSize:15.0];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //制定与图片之间的间距
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [imageView addSubview:shareBtn];
    
    
    //2.开始微博
    UIButton *startBtn =  [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size  = startBtn.currentBackgroundImage.size;
    startBtn.centerX  = shareBtn.centerX;
    startBtn.centerY  = imageView.height * 0.75;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

-(void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected =  !shareBtn.isSelected;
}

-(void)startClick
{
    //切换到HWTabBarController控制器
    //这是新特性控制器就被销毁了，因为没有强引用它了；
    [UIApplication sharedApplication].keyWindow.rootViewController = [[HMMainTabBarController alloc]init];
    
}

-(void)dealloc
{
        NSLog(@"%s\n",__func__);
}
@end

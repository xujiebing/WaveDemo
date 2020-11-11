//
//  ViewController.m
//  WaveDemo
//
//  Created by 徐结兵 on 2020/8/18.
//  Copyright © 2020 徐结兵. All rights reserved.
//
 
#import "ViewController.h"
#import "WaveView.h"
 
@interface ViewController ()
 
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *pointArray;
@property (nonatomic, strong) WaveView *drawView;
@property (nonatomic, weak) UIView *proView;
@property (nonatomic, weak) UIButton *startButton;
 
@end
 
@implementation ViewController
 
- (NSMutableArray *)pointArray
{
    if (_pointArray == nil) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor blackColor];
    
    //创建控件
    [self creatControl];
}
 
- (void)creatControl
{
    //动画视图
    WaveView *view = [[WaveView alloc] initWithFrame:CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width - 60, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.drawView = view;
    
    //提示视图
    UIView *proView = [[UIView alloc] initWithFrame:CGRectMake(30, 260, 20, 20)];
    proView.backgroundColor = [UIColor greenColor];
    proView.hidden = YES;
    proView.layer.cornerRadius = 10;
    proView.clipsToBounds = YES;
    [self.view addSubview:proView];
    self.proView = proView;
    
    //开始按钮
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60) * 0.5 - 60, 300, 60, 60)];
    startBtn.backgroundColor = [UIColor redColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.startButton = startBtn;
    
    //停止按钮
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 60) * 0.5 + 60, 300, 60, 60)];
    stopBtn.backgroundColor = [UIColor redColor];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}
 
- (void)startBtnOnClick
{
    self.startButton.enabled = NO;
    self.proView.hidden = NO;
    
    //添加定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:.05f target:self selector:@selector(addPoint) userInfo:nil repeats:YES];
    //分流定时器
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
 
- (void)addPoint
{
    //随机点20～100
    CGPoint point = CGPointMake(0, arc4random_uniform(30) + 5);
    
    //插入到数组最前面（动画视图最右边），array添加CGPoint需要转换一下
//    [self.pointArray insertObject:[NSValue valueWithCGPoint:point] atIndex:0];
    [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    
    //传值，重绘视图
    self.drawView.pointArray = self.pointArray;
}
 
- (void)stopBtnOnClick
{
    self.startButton.enabled = YES;
    self.proView.hidden = YES;
    
    //移除定时器
    [self removeTimer];
}
 
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}
 
@end

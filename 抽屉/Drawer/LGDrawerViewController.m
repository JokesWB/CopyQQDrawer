//
//  LGDrawerViewController.m
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LGDrawerViewController.h"

#define kAnimationDuration 0.3

@interface LGDrawerViewController ()

@property (nonatomic , strong) UIViewController *mainVC;
@property (nonatomic , strong) UIViewController *leftVC;
@property (nonatomic , assign) CGFloat leftWidth;
@property (nonatomic , assign) CGFloat mainScale;
@property (nonatomic , strong) UIButton *coverBtn;

@end

@implementation LGDrawerViewController

// 返回当前控制器
+ (instancetype)sharedDrawer
{
    return (LGDrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

+ (instancetype)setMainViewController:(UIViewController *)mainVC LeftViewController:(UIViewController *)leftVC LeftWidth:(CGFloat)leftWidth MainViewScale:(CGFloat)mainScale
{
    LGDrawerViewController *drawerVC = [self new];
    drawerVC.mainVC = mainVC;
    drawerVC.leftVC = leftVC;
    drawerVC.leftWidth = leftWidth;
    drawerVC.mainScale = mainScale;
    
    [drawerVC.view addSubview:leftVC.view];
    leftVC.view.frame = drawerVC.view.bounds;
    [drawerVC addChildViewController:leftVC];
    leftVC.view.transform = CGAffineTransformMakeTranslation(-leftWidth, 0);
    
    [drawerVC.view addSubview:mainVC.view];
    mainVC.view.frame = drawerVC.view.bounds;
    [drawerVC addChildViewController:mainVC];
    
    
    
    return drawerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置 mainVC 的阴影
    self.mainVC.view.layer.shadowOffset = CGSizeMake(-5, 0);
    self.mainVC.view.layer.shadowColor = [UIColor grayColor].CGColor;
    self.mainVC.view.layer.shadowRadius = 3;
    self.mainVC.view.layer.shadowOpacity = 0.5;
    
    // 给mainVC的子控制器添加边缘拖拽手势
    for (UIViewController *childVC in self.mainVC.childViewControllers) {
        [self addEdgePanGestureRecognizerToView:childVC.view];
    }
    
}

// 添加边缘拖拽手势
- (void)addEdgePanGestureRecognizerToView:(UIView *)view
{
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureRecognizer:)];
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:edgePanGestureRecognizer];
}

//边缘拖拽手势
- (void)edgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGFloat offsetX = [pan translationInView:pan.view].x;
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        if (offsetX >= self.leftWidth * 0.5) {
            [self openDrawerUseTime:(self.leftWidth - offsetX) * kAnimationDuration / self.leftWidth];
        } else {
            [self closeDrawerUseTime:offsetX * kAnimationDuration / self.leftWidth];
        }
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(MIN(offsetX, self.leftWidth), 0);
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(MIN(-self.leftWidth + offsetX, 0), 0);
        
    }
}

// 监听按钮的拖拽手势
- (void)coverBtnPanGesture:(UIPanGestureRecognizer *)pan
{
    CGFloat offsetX = [pan translationInView:pan.view].x;
    NSLog(@"%f", offsetX);
    if (offsetX > 0) return;
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        if (ABS(offsetX) <= self.leftWidth * 0.5) {
            [self openDrawerUseTime:ABS(offsetX) * kAnimationDuration / self.leftWidth];
        } else {
            [self closeDrawerUseTime:(self.leftWidth + offsetX) * kAnimationDuration / self.leftWidth];
        }
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(MAX(offsetX + self.leftWidth, 0), 0);
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
}

// 打开抽屉
- (void)openDrawerUseTime:(CGFloat)duration
{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftWidth, 0);
        self.leftVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.mainVC.view addSubview:self.coverBtn];
    }];
}

// 关闭抽屉
- (void)closeDrawerUseTime:(CGFloat)duration
{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        //左边菜单缩放
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);
    } completion:^(BOOL finished) {
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
    }];
}

// 点击关闭按钮
- (void)closeDrawer
{
    [self closeDrawerUseTime:kAnimationDuration];
}

// 推出左边菜单的控制器
- (void)pushViewController:(UIViewController *)viewController
{
    if ([self.mainVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self.mainVC;
        [nav pushViewController:viewController animated:NO];
        [self closeDrawerUseTime:0.1];
    } else {
        id<LGDrawerViewControllerDelegate> delegate = (id<LGDrawerViewControllerDelegate>)self.mainVC;
        if ([delegate respondsToSelector:@selector(getNavigationController)]) {
            UINavigationController *nav = [delegate getNavigationController];
            [nav pushViewController:viewController animated:NO];
            [self closeDrawerUseTime:0.1];
        }
    }
}

// 覆盖在主页面上的按钮
- (UIButton *)coverBtn
{
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverBtn.frame = self.view.bounds;
        _coverBtn.backgroundColor = [UIColor clearColor];
        [_coverBtn addTarget:self action:@selector(closeDrawer) forControlEvents:UIControlEventTouchUpInside];
        // 给btn添加拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(coverBtnPanGesture:)];
        [_coverBtn addGestureRecognizer:pan];
    }
    return _coverBtn;
}



@end

//
//  LGDrawerViewController.h
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGDrawerViewControllerDelegate <NSObject>

- (UINavigationController *)getNavigationController;

@end

@interface LGDrawerViewController : UIViewController

/**
  * mainVC : 主页面控制器
  * leftVC : 左边菜单控制器
  * leftWidth : 左边控制器视图显示宽度
  * leftScale : 主页面缩放比例，设为 1 则不缩放
 */
+ (instancetype)setMainViewController:(UIViewController *)mainVC LeftViewController:(UIViewController *)leftVC LeftWidth:(CGFloat)leftWidth MainViewScale:(CGFloat)mainScale;

// 返回当前控制器
+ (instancetype)sharedDrawer;

// 打开抽屉
- (void)openDrawerUseTime:(CGFloat)duration;

// 点击左边菜单时推出的控制器
- (void)pushViewController:(UIViewController *)viewController;

@end

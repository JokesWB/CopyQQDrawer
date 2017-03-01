//
//  LGNavigationViewController.m
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LGNavigationViewController.h"

@interface LGNavigationViewController ()

@end

@implementation LGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end

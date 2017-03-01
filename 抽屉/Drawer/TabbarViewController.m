//
//  TabbarViewController.m
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "TabbarViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "LGNavigationViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[OneViewController new] Title:@"one"];
    
    [self addChildViewController:[TwoViewController new] Title:@"two"];
    
    [self addChildViewController:[ThreeViewController new] Title:@"three"];
    
    
    
}

- (void)addChildViewController:(UIViewController *)childController Title:(NSString *)title
{
    childController.title = title;
    LGNavigationViewController *nav = [[LGNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

- (UINavigationController *)getNavigationController
{
    return self.selectedViewController;
}

@end

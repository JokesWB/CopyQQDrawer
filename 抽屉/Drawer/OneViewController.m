//
//  OneViewController.m
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "OneViewController.h"
#import "LGDrawerViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleDone target:self action:@selector(showLeft)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"啊哈哈" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonAction
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

// 显示左边菜单
- (void)showLeft
{
    [[LGDrawerViewController sharedDrawer] openDrawerUseTime:0.3];
}


@end

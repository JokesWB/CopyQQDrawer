//
//  LeftTableViewController.m
//  抽屉
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LeftTableViewController.h"
#import "LGDrawerViewController.h"

@interface LeftTableViewController ()
{
    NSArray *array;
}

@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.tableView.backgroundColor = [UIColor greenColor];
    array = @[@"我的", @"你的", @"他的", @"大家的"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    aView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = aView;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *VC = [UIViewController new];
    VC.view.backgroundColor = [UIColor whiteColor];
    VC.title = array[indexPath.row];
    [[LGDrawerViewController sharedDrawer] pushViewController:VC];
}



@end

//
//  MessageTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MessageTableViewController.h"
#import "JiuZhuangHui.h"

@interface MessageTableViewController ()

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = kHeaderViewColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 200,kScreen_Width,100)];
    label.font = [UIFont systemFontOfSize:24];
    label.text = @"你没有收到任何消息";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    self.tableView.tableFooterView = view;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end

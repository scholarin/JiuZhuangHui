//
//  SettNameTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SettNameTableViewController.h"
#import "JiuZhuangHui.h"
#import "BlocksKit+UIKit.h"
#import "NetRequestManeger.h"
#import "BasicTableHeaderView.h"

@interface SettNameTableViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *textField;

@end

@implementation SettNameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(updateName)];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [self tableFooterView];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)updateName{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager postUserInfoWithCateory:self.category info:self.name reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"请求错误，%@",error);
            return ;
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreen_Width-40, 44)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.text = self.name;
    textField.font = [UIFont systemFontOfSize:15];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [cell addSubview:textField];
    self.textField = textField;
    return cell;
}

- (UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    view.backgroundColor = kHeaderViewColor;
    [view bk_whenTapped:^{
        [self.textField resignFirstResponder];
    }];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreen_Width-40,30)];
    label.text = @"4-20个字符，可由英文，数字，下划线组成";
    label.font = [UIFont systemFontOfSize:10];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[BasicTableHeaderView alloc]init];
}

#pragma mark - textfield delegate

- (void)textFieldDidChanged:(UITextField *)textField{
    self.name = textField.text;
}
@end

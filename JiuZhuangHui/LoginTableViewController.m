//
//  LoginTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LoginTableViewController.h"
#import "JiuZhuangHui.h"
#import "BlocksKit+UIKit.h"
#import "BasicTableHeaderView.h"
#import "NetRequestManeger.h"
#import "LogIn.h"

@interface LoginTableViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneTextField;
@property (nonatomic, strong)UITextField *passWordTextField;
@property (nonatomic, strong)UIButton *loginButton;

@end

@implementation LoginTableViewController{
    NSInteger _textFieldLength;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldLength = 0;
    self.title = @"登陆";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(logon)];
    self.tableView.tableFooterView = [self footerView];
    self.tableView.scrollEnabled = NO;
}


- (UIView *)footerView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width , kScreen_Height)];
    view.backgroundColor = kHeaderViewColor;
    
    UIButton *loginButton = [[UIButton alloc]init];
    [loginButton setBackgroundColor:[UIColor lightGrayColor]];
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
//    [loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
//    [loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(view).offset(20);
        make.height.equalTo(@40);
    }];
    loginButton.enabled = NO;
    self.loginButton = loginButton;
    
    UIButton *forgetPassWordButton = [[UIButton alloc]init];
    NSAttributedString *forgetButtonTitle = [[NSAttributedString alloc]initWithString:@"忘记密码？"
                                                                          attributes:@{
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                                                       }];
    [forgetPassWordButton setAttributedTitle:forgetButtonTitle forState:UIControlStateNormal];
    [forgetPassWordButton addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:forgetPassWordButton];
    [forgetPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.top.equalTo(loginButton.mas_bottom).offset(20);
    }];
    
    UIButton *loginUsePhoneButton = [[UIButton alloc]init];
    NSAttributedString *loginUsePhoneTitle = [[NSAttributedString alloc]initWithString:@"手机动态登陆"
                                                                           attributes:@{
                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                        NSForegroundColorAttributeName : [UIColor redColor]
                                                                                        }];
    [loginUsePhoneButton setAttributedTitle:loginUsePhoneTitle forState:UIControlStateNormal];
    [loginUsePhoneButton addTarget:self action:@selector(loginUsePhone) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginUsePhoneButton];
    [loginUsePhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(loginButton.mas_bottom).offset(20);
    }];
    
    [view bk_whenTapped:^{
        [self.phoneTextField resignFirstResponder];
        [self.passWordTextField resignFirstResponder];
    }];
    return view;
}

- (void)logon{
    
}

- (void)login{
    if(self.phoneTextField.text.length == 13 && self.passWordTextField.text.length >= 8 && self.passWordTextField.text.length <= 16){
        [self requesLogin];
    }
}


- (void)requesLogin{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    NSString *loginURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/user/signin";
    NSString *phoneNumber = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *postString = [NSString stringWithFormat:@"\"%@\":\"%@\",\"%@\":\"%@\"",@"name",phoneNumber,@"password",self.passWordTextField.text];
    [manager getUserInfoWithURL:loginURL PostString:postString reponse:^(id reponseObject, NSError * error) {
        if(error){
            NSLog(@"网络请求出现错误，错误代码%@",error);
            return ;
        }
        if([reponseObject[@"status"][@"succeed"] integerValue] == 0){
            NSLog(@"用户名或者密码错误，请重新输入");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入错误" message:@"您输入的账号或者密码有误请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:NO completion:nil];
            return;
        }
        NSDictionary *logInDic = @{
                                   @"sid": reponseObject[@"data"][@"session"][@"sid"],
                                   @"uid": reponseObject[@"data"][@"session"][@"uid"]
                                   };
        [LogIn loginWithData:logInDic];
        [self goUserInfo];
    }];
}


- (void)goUserInfo{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)forgetPassWord{
    
}

- (void)loginUsePhone{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 44)];
    label.font = [UIFont systemFontOfSize:15];
    [cell addSubview:label];
    
    UITextField *textField = [[UITextField alloc]init];
    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor lightGrayColor];
    textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
    [textField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [cell addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell).offset(-10);
        make.left.equalTo(label.mas_right).offset(10);
        make.top.bottom.equalTo(cell);
    }];
    
    if(indexPath.row == 0){
        label.text = @"账号";
        textField.placeholder = @"请输入您的手机号";
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        self.phoneTextField = textField;
    }else{
        label.text = @"密码";
        textField.placeholder = @"请输入登陆密码";
        textField.secureTextEntry = YES;
        self.passWordTextField = textField;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[BasicTableHeaderView alloc]init];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark textFieldDelegate;
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.phoneTextField.text.length > 0 && self.passWordTextField.text.length >= 8 && self.passWordTextField.text.length <= 16){
        self.loginButton.enabled = YES;
        [self.loginButton setBackgroundColor:[UIColor orangeColor]];
    }else{
        self.loginButton.enabled = NO;
        [self.loginButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    
}
- (void)textFieldDidEditing:(UITextField *)textField{
    if(self.phoneTextField.text.length > 0 && self.passWordTextField.text.length >= 8 && self.passWordTextField.text.length <= 16){
        self.loginButton.enabled = YES;
        [self.loginButton setBackgroundColor:[UIColor orangeColor]];
    }else{
        self.loginButton.enabled = NO;
        [self.loginButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    if(textField == self.phoneTextField){
        if(textField.text.length > _textFieldLength){
            if(textField.text.length == 3){
                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
            }else if(textField.text.length == 8){
                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
            }else if(textField.text.length >= 13){
                [textField resignFirstResponder];
            }
        }
        _textFieldLength = textField.text.length;
    }
}

@end

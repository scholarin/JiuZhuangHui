//
//  UserInfoViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserInfoViewController.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "LogIn.h"
#import "NetRequestManeger.h"
#import "BasicTableHeaderView.h"
#import "LoginTableViewController.h"
#import "SettingTableViewController.h"
#import "MessageTableViewController.h"
#import "User.h"

static NSString *const useInfoURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/userinfo";

@interface UserInfoViewController ()

@property(nonatomic, copy)NSString *topImage;
@property(nonatomic, strong)User *currentUser;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员中心";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"set"] style:UIBarButtonItemStylePlain target:self action:@selector(settingMyAccount)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bell"] style:UIBarButtonItemStylePlain target:self action:@selector(goMessage)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateUI)];
    self.tableView.tableFooterView = [[BasicTableHeaderView alloc]initWithHeight:40];
    
    [self requestUserInfo];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self requestUserInfo];
}

- (void)updateUI{
    [self requestUserInfo];
    [self.tableView.mj_header endRefreshing];
}

- (BOOL)isLogin{
    return [LogIn isLogIn];
}

- (void)settingMyAccount{
   if(!self.isLogin){
        [self goToLogIn];
   }else{
        SettingTableViewController *settingVC = [[SettingTableViewController alloc]init];
        settingVC.currentUser = self.currentUser;
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

- (void)goMessage{
    MessageTableViewController *messageVC = [[MessageTableViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)goToLogIn{
    LoginTableViewController *logInTVC = [[LoginTableViewController alloc]init];
    logInTVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:logInTVC animated:YES];
}

- (UIView *)tableHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 120)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
    [view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topImage]];
    return view;
}

- (void)requestUserInfo{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    if(self.isLogin){
        NSString *postString  = [LogIn JSONWithCurrentUser];
        [manager getUserInfoWithURL:useInfoURL PostString:postString reponse:^(id reponseObject, NSError *error) {
            if(error){
                NSLog(@"用户信息网络请求错误，%@",error);
                return;
            }
            self.topImage = reponseObject[@"data"][@"focus_img"];
            self.currentUser = [[User alloc]initWithData:reponseObject];
            [self.tableView reloadData];
        }];
    }else{
        [manager getUserInfoWithURL:useInfoURL PostString:nil reponse:^(id  _Nullable reponseObject, NSError * _Nullable error) {
            if(error){
                NSLog(@"用户信息网络请求错误，%@",error);
                return;
            }
            self.topImage = reponseObject[@"data"][@"focus_img"];
            [self.tableView reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)orderCell{
    NSArray *buttonImage = @[@"pay",@"shouhuo",@"pingjia",@"shouhou"];
    NSArray *orderType = @[@"待付款",@"待收货",@"待评价",@"售后"];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
    CGFloat buttonheight = 40.0;
    CGFloat buttonSpacing = (kScreen_Width - 4 * buttonheight)/4;
    for(int i = 0; i < 4; i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonSpacing/2 + i * (buttonheight + buttonSpacing) , 0, 40, 40)];
        button.tag = i;
        [button setImage:[UIImage imageNamed:buttonImage[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goOrderType:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(buttonSpacing/2 + i * (buttonheight + buttonSpacing), 40, 40, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = orderType[i];
        label.font = [UIFont systemFontOfSize:12];
        [cell addSubview:label];
    }
    return cell;
}

- (void)goOrderType:(UIButton *)sender{
    NSLog(@"按钮被点击拉！");
}
#pragma  mark - tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 4){
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            [cell addSubview: [self tableHeaderView]];
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
            cell.imageView.layer.cornerRadius = 20;
            cell.imageView.clipsToBounds = YES;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            if(!self.isLogin){
                cell.textLabel.text = @"未登陆";
                cell.detailTextLabel.text = @"登陆/注册";
                cell.imageView.image = [UIImage imageNamed:@"head"];
            }else{
                cell.textLabel.text = self.currentUser.virtualName;
                cell.detailTextLabel.text = @"账号管理";
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.currentUser.icon] placeholderImage:[UIImage imageNamed:@"head"]];
            }
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"shopCell"];
            cell.imageView.image = [UIImage imageNamed:@"dingdan"];
            cell.textLabel.text = @"我的订单";
            cell.detailTextLabel.text = @"查看全部订单";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else{
            UITableViewCell *cell = [self orderCell];
            return cell;
        }
    }else if(indexPath.section == 2){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"moneyCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if(indexPath.row == 0){
            cell.imageView.image = [UIImage imageNamed:@"money"];
            cell.textLabel.text = @"我的零钱包";
        }else if(indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"youhuiquan"];
            cell.textLabel.text = @"我的优惠券";
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            if(self.isLogin){
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld张可用",self.currentUser.voucherCount];
            }
            
        }
        return cell;
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactCell"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"客服热线";
            cell.imageView.image = [UIImage imageNamed:@"kefu"];
            UILabel *phoneLabel = [[UILabel alloc]init];
            phoneLabel.text = @"0951-5155830";
            phoneLabel.textColor = [UIColor redColor];
            phoneLabel.font = [UIFont systemFontOfSize:13];
            [cell addSubview:phoneLabel];
            [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell).offset(5);
                make.right.equalTo(cell).offset(-30);
            }];
            
            UILabel *workTimeLabel = [[UILabel alloc]init];
            workTimeLabel.text = @"周一到周五，8:30-18:00";
            workTimeLabel.font = [UIFont systemFontOfSize:10];
            workTimeLabel.textColor = [UIColor lightGrayColor];
            [cell addSubview:workTimeLabel];
            [workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(phoneLabel.mas_bottom);
                make.right.equalTo(cell).offset(-30);
            }];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
        }else {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aboutCell"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"关于酒庄惠";
            cell.imageView.image = [UIImage imageNamed:@"wine"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wechat"];
        cell.imageView.image = [UIImage imageNamed:@"wechat"];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:@"如有更多问题，可关注微信服务号”“随时订货" attributes:@{
                                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                                                                                }];
        NSAttributedString *jiuzhuanghui = [[NSAttributedString alloc]initWithString:@"酒庄惠"
                                                                          attributes:@{
                                                                NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                     NSForegroundColorAttributeName : [UIColor redColor]
                                                                                    }];
        [attString insertAttributedString:jiuzhuanghui atIndex:16];
        
        cell.textLabel.attributedText = attString;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0) return 120;
    if(indexPath.section == 0 && indexPath.row == 1) return 50;
    if(indexPath.section == 1 && indexPath.row == 1) return 60;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[BasicTableHeaderView alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 1){
            [self settingMyAccount];
        }
        
    }else if(indexPath.section == 3 && indexPath.row == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:0951-5155830"]];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

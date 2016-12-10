//
//  UserTalkViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/3.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserTalkViewController.h"
#import "UserTalkTableViewCell.h"
#import "BasicTableHeaderView.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "NetRequestManeger.h"

#import "UserTalkModel.h"
#import "WineTastingModel.h"
#import "WineryDetailWebView.h"
#import "WineTastingTableViewController.h"

#import "WineTastingListViewController.h"
#import "OwerStoryTableViewController.h"
#import "WineryAritcleTableViewController.h"
#import "WineryWorkerTableViewController.h"
#import "LawsCollectionViewController.h"
#import "TalkTableViewController.h"
#import "UserTalkTableViewController.h"

static NSString *const kUserTalkTableViewCell = @"userTalkTableViewCell";
@interface UserTalkViewController ()<UserTalkTableViewCellDelegate>

@property(nonatomic, strong)NSString *topImageURL;
@property(nonatomic, strong)NSArray *userTalkList;
@property(nonatomic, strong)NSArray *wineTastingList;

@end

@implementation UserTalkViewController{
    NSMutableArray *_cellImages;
    NSArray *_cellNames;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellImages = [NSMutableArray new];
    for(int i = 0; i < 9; i++){
        NSString *string = [NSString stringWithFormat:@"usertalk%d",i];
        [_cellImages addObject:string];
    }
    _cellNames = @[@"用户说",@"酒评圈",@"申请接收用户采访",@"申请成为酒庄惠支持者",@"庄主故事",@"欧盟SGS检测报告",@"产区人",@"产区法律",@"吐槽我们"];

    BasicTableHeaderView *view = [[BasicTableHeaderView alloc]initWithHeight:40];
    self.tableView.tableFooterView = view;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UserTalkTableViewCell class] forCellReuseIdentifier:kUserTalkTableViewCell];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self requestUserTastingData];
    // Do any additional setup after loading the view.
}


- (void)requestUserTastingData{
    
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getUserTalkDataReponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"%@",error);
            return;
        }
        self.topImageURL = reponseObject[@"data"][@"focus_img"];
        self.userTalkList = [UserTalkModel getUserTalkListWithData:reponseObject];
        self.wineTastingList = [WineTastingModel getWineTastingListWith:reponseObject];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = 0;
    if(section == 0 || section == 6){
        number = 1;
    }else{
        number = 2;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Header"];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL: [NSURL URLWithString: self.topImageURL]];
        [cell addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(cell);
        }];
        return cell;
    }else if((indexPath.section == 1 && indexPath.row == 1) || (indexPath.section == 2 && indexPath.row == 1)){
        UserTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserTalkTableViewCell];
        cell.delegate = self;
        if(indexPath.section == 1){
            [cell setCollectionViewData:self.userTalkList andType:CollectionViewTypeUserTalk];
        }else{
            [cell setCollectionViewData:self.wineTastingList andType:CollectionViewTypeWineTasting];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if(indexPath.section == 1){
            cell.detailTextLabel.text = @"中国葡萄酒庄用户说";
            cell.textLabel.text = _cellNames[0];
            cell.imageView.image = [UIImage imageNamed:_cellImages[0]];
        }else if(indexPath.section == 2){
            cell.detailTextLabel.text = @"中国葡萄庄园酒评圈";
            cell.textLabel.text = _cellNames[1];
            cell.imageView.image = [UIImage imageNamed:_cellImages[1]];
        }else if(indexPath.section == 3){
            if(indexPath.row == 0){
                cell.textLabel.text = _cellNames[2];
                cell.imageView.image = [UIImage imageNamed:_cellImages[2]];
            }else{
                cell.textLabel.text = _cellNames[3];
                cell.imageView.image = [UIImage imageNamed:_cellImages[3]];
            }
        }else if(indexPath.section == 4){
            if(indexPath.row == 0){
                cell.textLabel.text = _cellNames[4];
                cell.imageView.image = [UIImage imageNamed:_cellImages[4]];
            }else{
                cell.textLabel.text = _cellNames[5];
                cell.imageView.image = [UIImage imageNamed:_cellImages[5]];
            }
        }else if(indexPath.section == 5){
            if(indexPath.row == 0){
                cell.textLabel.text = _cellNames[6];
                cell.imageView.image = [UIImage imageNamed:_cellImages[6]];
            }else{
                cell.textLabel.text = _cellNames[7];
                cell.imageView.image = [UIImage imageNamed:_cellImages[7]];
            }
        }else{
            cell.textLabel.text = _cellNames[8];
            cell.imageView.image = [UIImage imageNamed:_cellImages[8]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if(indexPath.section == 0 ||(indexPath.section == 1 &&indexPath.row == 1) || (indexPath.section == 2 && indexPath.row == 1)){
        height = 160;
    }else{
        height = 45;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if(section == 0){
        height = 0;
    }else{
        height = 10;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0) return nil;
    BasicTableHeaderView *headerview = [[BasicTableHeaderView alloc]init];
    return headerview;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1 ){
        UserTalkTableViewController *userTalkVC = [[UserTalkTableViewController alloc]init];
        userTalkVC.hidesBottomBarWhenPushed = YES;
        userTalkVC.title = @"中国葡萄庄园酒 用户说";
        [self.navigationController pushViewController:userTalkVC animated:YES];
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        WineTastingListViewController *wineTastingListVC = [[WineTastingListViewController alloc]init];
        [self.navigationController pushViewController:wineTastingListVC animated:YES];
    }else if(indexPath.section == 3){
        UIViewController *webVC = [[UIViewController alloc]init];
        UIWebView *webView = [[UIWebView alloc]initWithFrame:webVC.view.bounds];
        if(indexPath.row == 0){
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=discovery&a=interview_app"]]];
        }else{
             [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jiuzhuanghui.com/mobile/index.php?m=default&c=discovery&a=support_app"]]];
        }
        
        [webVC.view addSubview:webView];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if(indexPath.section == 4){
        if(indexPath.row == 0){
            OwerStoryTableViewController *owerStoryVC = [[OwerStoryTableViewController alloc]init];
            owerStoryVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:owerStoryVC animated:YES];
        }else if(indexPath.row == 1){
            WineryAritcleTableViewController *articleVC = [[WineryAritcleTableViewController alloc]init];
            articleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:articleVC animated:YES];
        }
    }else if(indexPath.section == 5){
        if(indexPath.row == 0){
            WineryWorkerTableViewController *wineryWorkerVC = [[WineryWorkerTableViewController alloc]init];
            [self.navigationController pushViewController:wineryWorkerVC animated:YES];
        }else if(indexPath.row == 1){
            LawsCollectionViewController *lawVC = [[LawsCollectionViewController alloc]init];
            [self.navigationController pushViewController:lawVC animated:YES];
        }
    }else{
        TalkTableViewController *talkVC = [[TalkTableViewController alloc]init];
        talkVC.hidesBottomBarWhenPushed = YES;
        talkVC.title = @"吐槽我们";
        [self.navigationController pushViewController:talkVC animated:YES];
    }
}

#pragma mark -UserTalkCollectionDelegate

- (void)UserTalkTableViewCell:(UserTalkTableViewCell *)cell didSelectedItem:(NSInteger)itme withType:(CollectionViewType)collectionType{
    if(collectionType == CollectionViewTypeUserTalk){
        //用winery的Webview进行跳转
        WineryDetailWebView *webView = [[WineryDetailWebView alloc]init];
        UserTalkModel *userTalk = self.userTalkList[itme];
        webView.topicURL = userTalk.userTalkDetailURL;
        [self.navigationController pushViewController:webView animated:YES];
    }else{
        
        WineTastingTableViewController *tastingTVC = [[WineTastingTableViewController alloc]init];
        WineTastingModel *wineTasting = self.wineTastingList[itme];
        [tastingTVC setWineTastingID:wineTasting.wineTastingID name:wineTasting.wineTastingName];
        tastingTVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tastingTVC animated:YES];
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

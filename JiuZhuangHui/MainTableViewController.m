//
//  MainTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainTableViewController.h"
#import "JiuZhuangHui.h"

#import "WinePurchaseModel.h"
#import "PanicBuyTableViewCell.h"
#import "NetRequestManeger.h"

#import "MainHeaderViewModel.h"
#import "MainHeaderView.h"




static  NSString  *kPanicBuyingPurchase = @"PanicBuyTableViewCell";
static  NSString  *kMainHeaderView = @"MainHeaderView";
@interface MainTableViewController ()

@property (strong, nonatomic)WinePurchaseModel *panicBuyingPurchase;
@property (strong, nonatomic)MainHeaderViewModel *mainHeaderViewModel;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒庄惠";
    
    [self.tableView registerNib:[UINib nibWithNibName:kPanicBuyingPurchase bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kPanicBuyingPurchase];
    [self requestPanicBuyingPurchase];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)requestPanicBuyingPurchase{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getMainViewInfoReponse:^(id reponseObject, NSError *error) {
        self.panicBuyingPurchase = [[WinePurchaseModel alloc] initWithPanicBuyData:reponseObject];
        self.mainHeaderViewModel = [[MainHeaderViewModel alloc]initWithData:reponseObject];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PanicBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPanicBuyingPurchase];
    [cell setUIWithWinePurchaseModel:self.panicBuyingPurchase];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PanicBuyTableViewCell heightForCell];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [MainHeaderView heightHeaderView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MainHeaderView *headerView = [MainHeaderView shareHeaderView];
    [headerView setHeaderViewData:self.mainHeaderViewModel];
    return headerView;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

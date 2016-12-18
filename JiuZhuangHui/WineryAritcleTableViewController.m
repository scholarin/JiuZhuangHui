//
//  WineryAritcleTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineryAritcleTableViewController.h"
#import "NetRequestManeger.h"
#import "WineryDetailWebView.h"
#import "WineryArticle.h"
#import "JiuZhuangHui.h"

#import "BasicTableHeaderView.h"

@interface WineryAritcleTableViewController ()

@property (nonatomic, copy)NSArray *articles;
@property (nonatomic, copy)NSString *topImageURL;

@end

@implementation WineryAritcleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"欧盟检测报告";
    self.tableView.scrollEnabled = NO;
    [self requestOwerStoryData];
    
    BasicTableHeaderView *footview = [[BasicTableHeaderView alloc]initWithHeight:200];
    self.tableView.tableFooterView = footview;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)requestOwerStoryData{
    NSString *owerSroryURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/articleList&cat_id=138&limit=7&page=1";
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getRequestWithURL:owerSroryURL reponse:^(id reponseObject, NSError *error) {
        self.articles = [WineryArticle getArticlesWithData:reponseObject];
        self.topImageURL = reponseObject[@"data"][@"focus_img"];
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 1;
    if(section == 0){
        num = 1;
    }else{
        num = self.articles.count;
    }
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        static NSString *imageCell = @"imageCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        if(!cell){
            cell = [[UITableViewCell alloc]init];
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.topImageURL]];
        [cell addSubview:imageView];
        return cell;
    }else{
        static NSString *articleCell = @"articleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCell];
        if(!cell){
            cell = [[UITableViewCell alloc]init];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        WineryArticle *article = self.articles[indexPath.row];
        cell.textLabel.text = article.articleName;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0 ;
    if(indexPath.section == 0){
        height = 150;
    }else{
        height = 45;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section ==  0) return 0;
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 0) return nil;
    return [[BasicTableHeaderView alloc]initWithHeight:10];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        WineryDetailWebView *wineryWebView = [[WineryDetailWebView alloc]init];
        WineryArticle *article = self.articles[indexPath.row];
        wineryWebView.wineryID = article.articleID;
        wineryWebView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wineryWebView animated:YES];
    }
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

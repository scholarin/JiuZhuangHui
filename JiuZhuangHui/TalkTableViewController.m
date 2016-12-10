//
//  TalkTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//http://www.jiuzhuanghui.com/ecmobile/?url=/tucao
//json	{"context":"你们的庄主故事页面为什么一刷新就挂了啊","session":{"sid":"34e7ba8cd0e5c8ca09028e3ecc436a9f3b654ed7","uid":5423},"user_id":5423}

#import "TalkTableViewController.h"
#import "JiuZhuangHui.h"
#import "BasicTableHeaderView.h"
#import "UIView+BlocksKit.h"
#import "UIAlertView+BlocksKit.h"

@interface TalkTableViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UITextField *contactTextField;
@property (nonatomic, strong)UILabel *textViewLabel;

@end

@implementation TalkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(upTalk)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [self tableFooterView];
    
}


- (void)upTalk{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width -20, 200)];
        _textView.text = @"你好，请描述你遇到的问题……";
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.textColor = [UIColor lightGrayColor];
        _textView.delegate = self;
    }
    return _textView;
}


- (UILabel *)textViewLabel{
    if(!_textViewLabel){
        _textViewLabel = [[UILabel alloc]init];
        _textViewLabel.font = [UIFont systemFontOfSize:10];
        _textViewLabel.textColor = [UIColor lightGrayColor];
        _textViewLabel.text = @"0/200";
        _textViewLabel.textAlignment = NSTextAlignmentRight;
    }
    return _textViewLabel;
}
- (UITextField *)contactTextField{
    if(!_contactTextField){
        _contactTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width -20, 40)];
        _contactTextField.placeholder = @"如需回复，请留下你的手机号码或邮箱（选填）";
        _contactTextField.font = [UIFont systemFontOfSize:13];
    }
    return _contactTextField;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 500)];
    view.backgroundColor = kHeaderViewColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width, 40)];
    label.textColor = [UIColor lightGrayColor];
    
    label.font = [UIFont systemFontOfSize:10];
    label.text = @"悄悄话:吐槽可以获优惠券哦！";
    [view addSubview:label];
    
    [view bk_whenTapped:^{
        [self.textView resignFirstResponder];
        [self.contactTextField resignFirstResponder];
    }];
    return view;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        [cell addSubview:self.textView];
        [self.textView addSubview:self.textViewLabel];
        self.textViewLabel.frame = CGRectMake(kScreen_Width - 150, 150, 100, 20);
        return cell;
        
        
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        [cell addSubview:self.contactTextField];
        return cell;
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height;
    if(indexPath.section == 0){
        height = 200;
    }else{
        height = 40;
    }
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[BasicTableHeaderView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height;
    if(section == 1){
        height = 40;
    }
    return 0;
}



#pragma mark - textViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    self.textViewLabel.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
    if(self.textView.text.length > 0){
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if([textView.text isEqualToString:@"你好，请描述你遇到的问题……"]){
        self.textView.text = nil;
    }
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor blackColor];
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
   
    
}

#pragma mark -textfieldDelegate



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

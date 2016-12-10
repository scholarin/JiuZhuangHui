//
//  SettingTableViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/10.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "SettingTableViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "BasicTableHeaderView.h"
#import "NetRequestManeger.h"
#import "LogIn.h"
#import "SettNameTableViewController.h"

static CGFloat iconWidth = 40;
static NSString *const useInfoURL = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/userinfo";
@interface SettingTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UIImageView *iconView;
@end

@implementation SettingTableViewController{
    NSArray *_userInfoCategory;
    NSArray *_userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userInfoCategory = @[@[@"头像",@"昵称",@"姓名",@"性别",@"出生日期"],@[@"地址管理"],@[@"登陆密码",@"绑定手机"]];
    [self setUserInfo];
    self.title = @"账户管理";
    self.tableView.tableFooterView = [self tableFootView];
    self.tableView.scrollEnabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self requestUserInfo];
}


- (void)setUserInfo{
    _userInfo = @[@[_currentUser.icon ? _currentUser.icon : @""
                    ,_currentUser.virtualName ? _currentUser.virtualName : @""
                    ,_currentUser.realName ? _currentUser.realName : @"",
                    _currentUser.sex ? [_currentUser.sex isEqualToString:@"1"] ? @"男" : @"女": @"",
                    _currentUser.birthday ? _currentUser.birthday : @""],
                  @[@"收获地址管理"],
                  @[@"修改登陆密码",
                    _currentUser.phoneNumber ? _currentUser.phoneNumber :@""]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)tableFootView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
    view.backgroundColor = kHeaderViewColor;
    UIButton *logOutButton = [[UIButton alloc]init];
    logOutButton.layer.cornerRadius = 3;
    logOutButton.clipsToBounds = YES;
    [logOutButton setBackgroundColor:[UIColor orangeColor]];
    NSAttributedString *buttonTitle = [[NSAttributedString alloc]initWithString:@"退出登陆" attributes:@{
                                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                                                                    NSForegroundColorAttributeName : [UIColor blackColor]
                                                                                                    }];
    [logOutButton setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:logOutButton];
    [logOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(view).offset(20);
        make.height.equalTo([NSNumber numberWithFloat:iconWidth]);
    }];
    return view;
}

- (void)logOut{
    [LogIn logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestUserInfo{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    NSString *postString  = [LogIn JSONWithCurrentUser];
    [manager getUserInfoWithURL:useInfoURL PostString:postString reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"用户信息网络请求错误，%@",error);
            return;
        }
        self.currentUser = [[User alloc]initWithData:reponseObject];
        [self setUserInfo];
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    if(section == 0){
        num = 5;
    }else if(section == 1){
        num = 1;
    }else{
        num = 2;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"userInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _userInfoCategory[indexPath.section][indexPath.row];
    if(indexPath.section == 0 && indexPath.row == 0){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 30 - iconWidth, 10, iconWidth, iconWidth)];
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = YES;
        [cell addSubview:imageView];
        [imageView sd_setImageWithURL:_userInfo[indexPath.section][indexPath.row] placeholderImage:[UIImage imageNamed:@"head"]];
        self.iconView = imageView;
    }else{
        cell.detailTextLabel.text = _userInfo[indexPath.section][indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if(indexPath.section == 0 && indexPath.row == 0){
        height = 60;
    }else{
        height = 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[BasicTableHeaderView alloc]init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            [self setIcon];
        }else if(indexPath.row == 1){
            SettNameTableViewController *setNameVc = [[SettNameTableViewController alloc]init];
            setNameVc.category = @"nickname";
            setNameVc.name = self.currentUser.virtualName;
            setNameVc.title =@"修改昵称";
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:setNameVc];
            [self presentViewController:navc animated:YES completion:nil];
        }else if(indexPath.row == 2){
            SettNameTableViewController *setNameVc = [[SettNameTableViewController alloc]init];
            setNameVc.category = @"name";
            setNameVc.name = self.currentUser.realName;
            setNameVc.title = @"修改姓名";
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:setNameVc];
            [self presentViewController:navc animated:YES completion:nil];
        }else if(indexPath.row == 3){
            [self setSex];
        }
    }
}



//修改头像
- (void)setIcon{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *caneclAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self userCamera];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self userPhoto];
    }];
    [alert addAction:caneclAction];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)userCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)userPhoto{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
#pragma  mark -imagepickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.iconView.image = [self shrinkImage:image toSize:CGSizeMake(iconWidth, iconWidth)];
    
    //将图片上传到服务器
    NSData *imageData = UIImagePNGRepresentation(self.iconView.image);
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager postUserIconWithData:imageData reponse:^(id reponseObject, NSError *error) {
        self.currentUser = [[User alloc]initWithData:reponseObject];
        
        //更新userINFO
        [self setUserInfo];
        [self.tableView reloadData];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//图片重新绘制
- (UIImage *)shrinkImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGRect rect = CGRectMake(0, 0, iconWidth, iconWidth);
    [image drawInRect:rect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

//修改性别
- (void)setSex{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *caneclAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self postResetSexWithSex:@"男"];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self postResetSexWithSex:@"女"];
    }];
    [alert addAction:caneclAction];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)postResetSexWithSex:(NSString *)sex{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager postUserInfoWithCateory:@"sex" info:[sex isEqualToString:@"男"] ? @"1" : @"0" reponse:^(id reponseObject, NSError *error) {
        self.currentUser = [[User alloc]initWithData:reponseObject];
        //更新userINFO
        [self setUserInfo];
        [self.tableView reloadData];
    }];
}
@end

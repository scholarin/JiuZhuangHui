//
//  FirstLuanchViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/30.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "FirstLuanchViewController.h"
#import "JiuZhuangHui.h"
#import "MNAutoScrollView.h"

#import "NetRequestManeger.h"

@interface FirstLuanchViewController ()<MNAutoScrollViewDelegate>
@property (strong, nonatomic)MNAutoScrollView *scrollView;
@property (strong, nonatomic)NSArray *imagesArray;
@property (strong, nonatomic)UIButton *enterButton;
@end

@implementation FirstLuanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showScrollView];
    [self showEnterButton];

}

//lazying load
- (NSArray *)imagesArray{
    if(!_imagesArray){
        NSMutableArray *array = [NSMutableArray new];
        for(int i = 0; i<4; i++){
            NSString *string = [NSString stringWithFormat:@"luanchImage_%d",i];
            [array addObject:string];
        }
        _imagesArray = array;
    }
    return _imagesArray;
}


- (void)showEnterButton{
    if(!_enterButton){
        _enterButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setBackgroundColor:[UIColor orangeColor]];
            NSDictionary *attributeDic = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:13]
                                           };
            NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:@"进入酒庄惠" attributes:attributeDic];
            [button setAttributedTitle:attributeString forState:UIControlStateNormal];
            button.hidden = YES;
            [button addTarget:self action:@selector(pushMainVC) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@30);
                make.width.equalTo(@200);
                make.centerX.equalTo(self.view.mas_centerX);
                make.bottom.equalTo(self.view.mas_bottom).offset(-45);
            }];
            button;
        });
    }
}


- (void)pushMainVC{
#warning 一会吧这个方法结束掉；
}


- (void)showScrollView{
    if(!_scrollView){
        _scrollView = [[MNAutoScrollView alloc]initWithFrame:kScreen_Bounds imageNames:self.imagesArray controllPage:PageControllStyleCenter];
        _scrollView.delegate = self;
        [_scrollView setControllIndictatorColor:[UIColor grayColor] currentIndicatorColor:[UIColor orangeColor]];
    }
    [self.view addSubview:_scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - scrollViewDelegate
- (void)scrollViewDidScrollAtLast:(MNAutoScrollView *)autoscrollView{
    self.enterButton.hidden = NO;
}

- (void)scrollViewDidScrollLeaveLast:(MNAutoScrollView *)autoscrollView{
    self.enterButton.hidden = YES;
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

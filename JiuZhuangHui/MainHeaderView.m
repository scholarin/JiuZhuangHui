//
//  MainHeaderView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/1.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "MainHeaderView.h"
#import "SDCycleScrollView.h"
#import "JiuZhuangHui.h"
#import "SDCycleScrollView.h"

#import "MainHeaderViewModel.h"
#import "TopItemModel.h"
#import "PlayerPictureModel.h"
#import "BottomButtonModel.h"


@interface MainHeaderView()<SDCycleScrollViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *topItems;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bottomButtonImage;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *bottomLabel;
@property (weak, nonatomic) IBOutlet UIView *playPictureView;
@property (strong, nonatomic) SDCycleScrollView *scrollView;

@end
@implementation MainHeaderView

+ (CGFloat)heightHeaderView{
    return 230;
}

- (void)setHeaderViewData:(MainHeaderViewModel *)model;{
    if(!model) return;
    //加载全部顶部Item数据
    for(UIButton *button in self.topItems){
        TopItemModel *topItemModel = nil;
        switch (button.tag) {
            case 1:{
                topItemModel = model.topItemsArray[0];
                [button setTitle:topItemModel.itemTitle forState:UIControlStateNormal];
            }
                break;
            case 2:{
                topItemModel = model.topItemsArray[1];
                [button setTitle:topItemModel.itemTitle forState:UIControlStateNormal];
            }
                break;
            case 3:{
                topItemModel = model.topItemsArray[2];
                [button setTitle:topItemModel.itemTitle forState:UIControlStateNormal];
            }
                break;
            case 4:{
                topItemModel = model.topItemsArray[3];
                [button setTitle:topItemModel.itemTitle forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }
    
    //picture数据
    NSArray *array = model.playerPictiuresArray;
    NSMutableArray *picArray = [NSMutableArray new];
    for(PlayerPictureModel *playerPictureModel in array){
        [picArray addObject:playerPictureModel.picPhoto];
    }
    
    
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 135) imageURLStringsGroup:picArray];
    self.scrollView.delegate = self;
    [self.playPictureView addSubview:self.scrollView];
    
    //底部button数据
    for(UIImageView *imageView in self.bottomButtonImage){
        BottomButtonModel *bottomButtonModel = nil;
        switch (imageView.tag) {
            case 1:{
                bottomButtonModel = model.bottomButtonsArray[0];
                [imageView sd_setImageWithURL:[NSURL URLWithString:bottomButtonModel.bottomImage]];
            }
                break;
            case 2:{
                bottomButtonModel = model.bottomButtonsArray[1];
                [imageView sd_setImageWithURL:[NSURL URLWithString:bottomButtonModel.bottomImage]];
            }
                break;
            case 3:{
                bottomButtonModel = model.bottomButtonsArray[2];
                [imageView sd_setImageWithURL:[NSURL URLWithString:bottomButtonModel.bottomImage]];
            }
                break;
            case 4:{
                bottomButtonModel = model.bottomButtonsArray[3];
                [imageView sd_setImageWithURL:[NSURL URLWithString:bottomButtonModel.bottomImage]];
            }
                break;
            default:
                break;
        }
    }
    
    for(UILabel *label in self.bottomLabel){
        BottomButtonModel *bottomButtonModel = nil;
        switch (label.tag) {
            case 1:{
                bottomButtonModel = model.bottomButtonsArray[0];
                
                label.text = bottomButtonModel.bottomName;
            }
                break;
            case 2:{
                bottomButtonModel = model.bottomButtonsArray[1];
                label.text = bottomButtonModel.bottomName;
            }
                break;
            case 3:{
                bottomButtonModel = model.bottomButtonsArray[2];
                label.text = bottomButtonModel.bottomName;
            }
                break;
            case 4:{
                bottomButtonModel = model.bottomButtonsArray[3];
                label.text = bottomButtonModel.bottomName;
            }
                break;
            default:
                break;
        }
    }
    
    
}

- (IBAction)bottomButtonPressed:(UIButton *)sender {
#warning 点击事件需要相应
    [self.delegate mainHeaderView:self didSelectedBottomButton:sender];
    
}


+ (instancetype)shareHeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:@"MainHeaderView" owner:self options:nil] lastObject];
}



- (IBAction)topItemClick:(UIButton *)sender {
    
    [self.delegate mainHeaderView:self didSelectedTopItem:sender];
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    [self.delegate mainHeaderView:self didSelectedScrollView:index];
    
}

@end

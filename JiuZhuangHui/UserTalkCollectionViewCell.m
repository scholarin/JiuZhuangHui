//
//  UserTalkCollectionViewCell.m
//  
//
//  Created by MosinNagant on 2016/12/6.
//
//

#import "UserTalkCollectionViewCell.h"
#import "JiuZhuangHui.h"
@interface UserTalkCollectionViewCell()

@property (nonatomic, strong)UIImageView *userImageView;
@property (nonatomic, strong)UILabel *userLabel;

@end

@implementation UserTalkCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _userImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_userImageView];
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(@100);
        }];
        
        _userLabel = [[UILabel alloc]init];
        _userLabel.textAlignment = NSTextAlignmentLeft;
        _userLabel.numberOfLines = 2;
        _userLabel.font = kDetailContentTextFont;
        
        [self.contentView addSubview:_userLabel];
        
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(_userImageView.mas_bottom);
        }];
    }
    return self;
}

- (void)setCellWithTitle:(NSString *)title Image:(NSString *)imageURL{
    
    self.userLabel.text = title;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
}
@end

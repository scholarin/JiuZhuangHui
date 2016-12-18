//
//  WineCountView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/12.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "WineCountView.h"

static NSString *const kShopCartNumberChange = @"shopCartNumberChange";
@interface WineCountView ()

@property (weak, nonatomic) IBOutlet UIButton *singleButton;
@property (weak, nonatomic) IBOutlet UIButton *boxButton;
@property (weak, nonatomic) IBOutlet UIButton *ruduceButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *addCartButton;
@property (weak, nonatomic) IBOutlet UILabel *wineCountLabel;
@property (assign,nonatomic) NSInteger wineCount;
@property (assign,nonatomic) NSInteger winePrice;

@end
@implementation WineCountView


- (void)drawRect:(CGRect)rect{
    self.singleButton.layer.borderWidth = 0.5;
    self.singleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.singleButton.layer.cornerRadius = 3;
    self.singleButton.clipsToBounds = YES;
    
    self.boxButton.layer.borderWidth = 0.5;
    self.boxButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.boxButton.layer.cornerRadius = 3;
    self.boxButton.clipsToBounds = YES;
    
    self.addButton.layer.borderWidth = 0.5;
    self.addButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addButton.layer.cornerRadius = 3;
    self.addButton.clipsToBounds = YES;
    
    self.ruduceButton.layer.borderWidth = 0.5;
    self.ruduceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ruduceButton.layer.cornerRadius = 3;
    self.ruduceButton.clipsToBounds = YES;
    
    self.wineCountLabel.layer.borderWidth = 0.5;
    self.wineCountLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.wineCountLabel.layer.cornerRadius = 3;
    self.wineCountLabel.clipsToBounds = YES;
    
    self.wineCountLabel.text = @"1";
    self.wineCount = 1;
    self.singleButton.selected = YES;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if(self = [super initWithCoder:aDecoder]){
//        self.singleButton.layer.borderWidth = 0.5;
//        self.singleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        self.boxButton.layer.borderWidth = 0.5;
//        self.boxButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        self.addButton.layer.borderWidth = 0.5;
//        self.addButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.ruduceButton.layer.borderWidth = 0.5;
//        self.ruduceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        self.wineCountLabel.layer.borderWidth = 0.5;
//        self.wineCountLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        self.wineCountLabel.text = @"1";
//        self.wineCount = 1;
//        self.singleButton.selected = YES;
//    }
//    return self;
//}

//- (void)setPriceLabel:(UILabel *)PriceLabel{
//    self.PriceLabel.text = PriceLabel.text;
//    self.winePrice = [[PriceLabel.text substringFromIndex:1] integerValue];
//}

+ (instancetype)share{
    return [[[NSBundle mainBundle]loadNibNamed:@"WineCountView" owner:self options:nil] lastObject];
}

- (void)setHasBox:(BOOL)hasBox{
    self.boxButton.hidden = !hasBox;
}

- (IBAction)reduceWine:(id)sender {
    if(self.wineCount > 1){
        self.wineCount--;
        self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wineCount];
    }
}

- (IBAction)addWine:(id)sender {
    self.wineCount++;
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wineCount];
}

- (IBAction)addCart:(id)sender {
    if(self.singleButton.selected == YES){
        [self.delegate wineCountView:self addToCartType:WineTypeSingle count:self.wineCount];
    }else if(self.boxButton.selected == YES){
        [self.delegate wineCountView:self addToCartType:WineTypeBox count:self.wineCount];
    }
}

- (IBAction)singleWineButton:(id)sender {
    if(self.boxButton.hidden){
        return;
    }
    if(self.singleButton.selected){
        return;
    }
    self.singleButton.selected = YES;
    self.boxButton.selected = NO;
    self.PriceLabel.text = [NSString stringWithFormat:@"¥%ld",self.winePrice];
}

- (IBAction)boxWineButton:(id)sender {
    if(self.boxButton.selected){
        return;
    }
    self.singleButton.selected = NO;
    self.boxButton.selected = YES;
    self.winePrice = [[self.PriceLabel.text substringFromIndex:1] integerValue];
    self.PriceLabel.text = [NSString stringWithFormat:@"¥%ld",self.winePrice * 6 - 20];
}



@end

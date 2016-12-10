//
//  User.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "User.h"

static NSString *const kPhoneNumber = @"phoneNumber";
static NSString *const kPassWord    = @"passWord";
static NSString *const kIcon        = @"icon";
static NSString *const kVirtualName = @"virtualName";
static NSString *const kRealName    = @"realName";
static NSString *const kSex         = @"sex";
static NSString *const kBirthday    = @"birthday";
static NSString *const kCreadedDate = @"creadedDate";
static NSString *const kLastLoginDate = @"lastLoginDate";
static NSString *const kLikeWine    = @"likeWine";
static NSString *const kAddressArray = @"addressArray";
static NSString *const kShopingCartWines = @"shopingCartWines";
static NSString *const kEmail = @"email";
static NSString *const kVoucherCount = @"voucherCount";

@implementation User


//@property (nonatomic, copy) NSString *phoneNumber, *passWord;
//@property (nonatomic, copy) NSString *icon, *virtualName, *realName, *sex, *birthday;
//@property (nonatomic, copy) NSString *creadedDate,*lastLoginDate;
//@property (nonatomic, copy) NSArray *likeWine;
//@property (nonatomic, copy) NSArray<Address *> *addressArray;
//@property (nonatomic, copy) NSArray<WinePurchaseModel*> *shopingCartWines;
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.phoneNumber   forKey:kPhoneNumber];
    [aCoder encodeObject:self.passWord      forKey:kPassWord];
    [aCoder encodeObject:self.icon          forKey:kIcon];
    [aCoder encodeObject:self.virtualName   forKey:kVirtualName];
    [aCoder encodeObject:self.realName      forKey:kRealName];
    [aCoder encodeObject:self.sex           forKey:kSex];
    [aCoder encodeObject:self.birthday      forKey:kBirthday];
    [aCoder encodeObject:self.createdDate   forKey:kCreadedDate];
    [aCoder encodeObject:self.lastLoginDate forKey:kLastLoginDate];
    [aCoder encodeObject:self.likeWine      forKey:kLikeWine];
    [aCoder encodeObject:self.addressArray  forKey:kAddressArray];
    [aCoder encodeObject:self.shopingCartWines forKey:kShopingCartWines];
    [aCoder encodeObject:self.email         forKey:kEmail];
    [aCoder encodeInteger:self.voucherCount forKey:kVoucherCount];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.phoneNumber    = [aDecoder decodeObjectForKey:kPhoneNumber];
        self.passWord       = [aDecoder decodeObjectForKey:kPassWord];
        self.icon           = [aDecoder decodeObjectForKey:kIcon];
        self.virtualName    = [aDecoder decodeObjectForKey:kVirtualName];
        self.realName       = [aDecoder decodeObjectForKey:kRealName];
        self.sex            = [aDecoder decodeObjectForKey:kSex];
        self.birthday       = [aDecoder decodeObjectForKey:kBirthday];
        self.createdDate    = [aDecoder decodeObjectForKey:kCreadedDate];
        self.lastLoginDate  = [aDecoder decodeObjectForKey:kLastLoginDate];
        self.likeWine       = [aDecoder decodeObjectForKey:kLikeWine];
        self.addressArray   = [aDecoder decodeObjectForKey:kAddressArray];
        self.shopingCartWines = [aDecoder decodeObjectForKey:kShopingCartWines];
        self.email          = [aDecoder decodeObjectForKey:kEmail];
        self.voucherCount   = [aDecoder decodeIntegerForKey:kVoucherCount];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    User *user = [[[self class]allocWithZone:zone]init];
    user.phoneNumber    = [_phoneNumber copy];
    user.passWord       = [_passWord copy];
    user.icon           = [_icon copy];
    user.virtualName    = [_virtualName copy];
    user.realName       = [_realName copy];
    user.sex            = [_sex copy];
    user.birthday       = [_birthday copy];
    user.createdDate    = [_createdDate copy];
    user.lastLoginDate  = [_lastLoginDate copy];
    user.likeWine       = [_likeWine copy];
    user.addressArray   = [_addressArray copy];
    user.shopingCartWines = [_shopingCartWines copy];
    user.email          = [_email copy];
    user.voucherCount = _voucherCount;
    return user;
}


- (instancetype)initWithData:(id)data{
    self = [super init];
    if(self){
        NSDictionary *userDic = data[@"data"];
        self.phoneNumber = userDic[@"user_name"];
        self.icon = userDic[@"user_img"];
        self.realName = userDic[@"name"];
        self.virtualName = userDic[@"nickname"];
        self.sex = userDic[@"sex"];
        self.birthday = userDic[@"birthday"];
        self.email = userDic[@"email"];
        self.createdDate  = userDic[@"reg_time"];
        self.voucherCount = [userDic[@"can_use_bonus_count"] integerValue];
    }
    return self;
}
@end

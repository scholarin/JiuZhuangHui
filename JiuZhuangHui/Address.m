//
//  Address.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/9.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "Address.h"


static NSString *const  kName    = @"name";
static NSString *const  kPhone   = @"phone";
static NSString *const  kRegion  = @"region";
static NSString *const  kStreet  = @"street";
static NSString *const  kDefault = @"isDefault";
@implementation Address

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name      forKey:kName];
    [aCoder encodeObject:self.phone     forKey:kPhone];
    [aCoder encodeObject:self.region    forKey:kRegion];
    [aCoder encodeObject:self.street    forKey:kStreet];
    [aCoder encodeBool:self.isDefault   forKey:kDefault];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.name       = [aDecoder decodeObjectForKey:kName];
        self.phone      = [aDecoder decodeObjectForKey:kPhone];
        self.region     = [aDecoder decodeObjectForKey:kRegion];
        self.street     = [aDecoder decodeObjectForKey:kStreet];
        self.isDefault  = [aDecoder decodeBoolForKey:kDefault];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    Address *address = [[[self class]allocWithZone:zone]init];
    address.name = [_name copy];
    address.phone = [_phone copy];
    address.region = [_region copy];
    address.street = [_street copy];
    address.isDefault = _isDefault;
    return address;
}


//@property (nonatomic, copy) NSString *name,*phone,*region,*street;
//@property (nonatomic, assign)BOOL isDefault;
@end

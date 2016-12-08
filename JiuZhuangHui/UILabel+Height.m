//
//  UILabel+Height.m
//  GroupPurchaseApp
//
//  Created by MosinNagant on 2016/11/26.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UILabel+Height.h"

@implementation UILabel (Height)

+ (CGFloat)labelHeightWithString:(NSString *)string{

    return [[self class]labelHeightWithString:string font:[UIFont systemFontOfSize:15]];
    
}


+ (CGFloat)labelHeightWithString:(NSString *)string font:(UIFont *)font{
    
    return [[self class]labelHeightWithString:string font:font offSet:0];
    
}

+ (CGFloat)labelHeightWithString:(NSString *)string font:(UIFont *)font offSet:(CGFloat)offset{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(kScreen_Width - 20 -offset, MAXFLOAT)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil].size;
    return contentSize.height;
}

@end

//
//  NSString+InputCheck.m
//  验证邮箱 qq   手机等
//
//  Created by 王烨谱 on 15/8/15.
//  Copyright (c) 2015年 王烨谱. All rights reserved.
//
#import "NSString+InputCheck.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (InputCheck)

- (BOOL) validateEmail

{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}



// ^[0-9]+$



- (BOOL) validateMobile

{
    
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|98)\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
//    //手机号以13， 15，18开头，八个 \d 数字字符
//    
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//        
//    return [phoneTest evaluateWithObject:self];
    
}



- (BOOL) validateUserId

{
    NSString *userIdRegex = @"^[0-9]+$";
    
    NSPredicate *userIdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userIdRegex];
    
    BOOL B = [userIdPredicate evaluateWithObject:self];
    
    if (![self hasPrefix:@"1"] && B) {
        
        return NO;
    }
    
    return B;
    
}



- (BOOL) validateqq

{
    NSString *qqRegex = @"[1-9][0-9]{5,10}";
    
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    
    return [qqTest evaluateWithObject:self];
    
}



- (BOOL) validateRealName

{
    
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:self];
    
}



- (BOOL) validateNickName

{
    
    NSString *userNameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,24}+$";
    
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    
    BOOL B = [userNamePredicate evaluateWithObject:self];
    
    return B;
    
}
- (CGRect)calculateHeightWithFont:(UIFont *)font labelWidth:(CGFloat)width{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect;
}

-(CGSize)calculateWidthFont:(UIFont *)font
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}
/**
 *  md5加密
 *
 *  @param input 输入的文本
 *
 *  @return 返回的md5加密后的内容
 */
- (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
/**
 *  utf8编码
 *
 *  @param UTF8String 编码string
 *
 *  @return 返回的编码内容
 */
- (NSString *)UTF8StringEncoding : (NSString *)UTF8String
{
    return [UTF8String  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end

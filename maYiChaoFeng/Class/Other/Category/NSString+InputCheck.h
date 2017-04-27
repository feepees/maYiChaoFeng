//
//  NSString+InputCheck.h
//  验证邮箱 qq   手机等
//
//  Created by 王烨谱 on 15/8/15.
//  Copyright (c) 2015年 王烨谱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (InputCheck)

- (BOOL) validateEmail;

- (BOOL) validateMobile;

- (BOOL) validateqq;

- (BOOL) validateRealName;

- (BOOL) validateNickName;

- (BOOL) validateUserId;

- (CGRect)calculateHeightWithFont:(UIFont *)font labelWidth:(CGFloat)width;

-(CGSize)calculateWidthFont:(UIFont *)font;

- (NSString *)md5HexDigest:(NSString*)input;

- (NSString *)UTF8StringEncoding : (NSString *)UTF8String;

@end

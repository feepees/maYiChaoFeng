//
//  UserDataTool.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/30.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataTool : NSObject
+(void)updataUserProfileWithValue:(NSString *)value andKey:(NSString *)key;
+(void)getUserProfile;
@end

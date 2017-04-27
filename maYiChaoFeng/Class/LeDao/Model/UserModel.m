//
//  UserModel.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UserModel.h"
#import <objc/runtime.h>
@implementation UserModel
HMSingletonM(UserModel)
//runtimer归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count=0;
    Ivar *ivars=class_copyIvarList([UserModel class], &count);
    
    for (int i=0; i<count; i++) {
        Ivar ivar=ivars[i];
        const char *name=ivar_getName(ivar);
        NSString *key=[NSString stringWithUTF8String:name];
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        unsigned int count=0;
        Ivar *ivars=class_copyIvarList([UserModel class], &count);
        for (int i = 0; i<count; i++) {
            Ivar ivar = ivars[i];
            //查看成员变量名称
            const char *name = ivar_getName(ivar);
            
            //解档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
            
            
        }
        free(ivars);

    }
    return self;
}
@end

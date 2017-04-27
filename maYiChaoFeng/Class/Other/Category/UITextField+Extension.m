//
//  UITextField+Extension.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/22.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

-(void)setImageName:(NSString *)imageName{
    UIImageView *leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [leftImage sizeToFit ];
    self.leftView=leftImage;
    self.leftViewMode=UITextFieldViewModeAlways;
}
-(NSString *)imageName{
    return nil;
}
@end


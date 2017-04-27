//
//  AddPurchaseCarView.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "AddPurchaseCarView.h"
@interface AddPurchaseCarView()
@end
@implementation AddPurchaseCarView
-(void)awakeFromNib{
    [super awakeFromNib];
NSLog(@"init");
}
- (IBAction)addCarAction:(id)sender {
    self.addCarAction();
}
- (IBAction)purchaseAction:(id)sender {
    self.purchaseAction();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

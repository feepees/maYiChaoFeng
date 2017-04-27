//
//  PurchaseViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/7.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "PurchaseViewController.h"

@interface PurchaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *wechatPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;

@end

@implementation PurchaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"购买会员";
    }
    return self;
}
- (IBAction)wechatPay:(id)sender {
    self.aliPayBtn.selected=NO;
    self.wechatPayBtn.selected=YES;
}
- (IBAction)aliPay:(id)sender {
    self.wechatPayBtn.selected=NO;
    self.aliPayBtn.selected=YES;
    
}
- (IBAction)payAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wechatPayBtn setImage:[UIImage imageNamed:@"gwc_xz_selected"] forState:UIControlStateSelected];
    [self.aliPayBtn setImage:[UIImage imageNamed:@"gwc_xz_selected"] forState:UIControlStateSelected];
    self.title=@"成为会员";
    
}

@end

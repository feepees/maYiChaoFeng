//
//  WalletViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "WalletViewController.h"
#import "BindingWXViewController.h"
@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的钱包";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)withDrawAction:(id)sender {
    BindingWXViewController *bindingC=[[BindingWXViewController alloc]init];
    [self.navigationController pushViewController:bindingC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

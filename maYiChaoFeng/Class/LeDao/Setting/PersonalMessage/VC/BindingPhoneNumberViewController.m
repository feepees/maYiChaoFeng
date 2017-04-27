//
//  BindingPhoneNumberViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "BindingPhoneNumberViewController.h"
#import "BindingNewPhoneNumViewController.h"
@interface BindingPhoneNumberViewController ()

@end

@implementation BindingPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *phoneNumberTF=[[UITextField alloc] initWithFrame:CGRectMake(Pading, 20, self.view.frame.size.width-Pading*2, controlHeight)];
    phoneNumberTF.placeholder=@"请输入当前的手机号";
    phoneNumberTF.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:phoneNumberTF];
    
    UIButton *nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(Pading, 75, self.view.frame.size.width-Pading*2, controlHeight)];
    
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"dlzc_an_bj"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    // Do any additional setup after loading the view.
}

-(void)next:(UIButton *)sender{
    NSLog(@"下一步");
    BindingNewPhoneNumViewController *newC=[[BindingNewPhoneNumViewController alloc]init];
    [self.navigationController pushViewController:newC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

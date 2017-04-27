//
//  ForgetPaasworldViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "ForgetPaasworldViewController.h"
#import "SettingNewPassworldViewController.h"

@interface ForgetPaasworldViewController ()

- (IBAction)getVerificationCode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTexrField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation ForgetPaasworldViewController

- (IBAction)nextBtn:(id)sender {
    
    SettingNewPassworldViewController *newPsaaworldC=[[SettingNewPassworldViewController alloc]init];
    newPsaaworldC.mobile=self.phoneNumberTexrField.text;
    [self.navigationController pushViewController:newPsaaworldC animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)getVerificationCode:(id)sender {
    
    UIButton *button=(UIButton *)sender;
    button.enabled=NO;
    __block int secend =10;
    int vrCode = (arc4random()%8999)+1000;
    NSLog(@"验证码是%d",vrCode);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (secend==0) {
            button.enabled=YES;
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftBtn setTitle:@"重试"forState:UIControlStateNormal];
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftBtn setTitle:[NSString stringWithFormat:@"%d秒后重试",secend]forState:UIControlStateNormal];
                secend--;
            });
            
        }
        
    });
    
    dispatch_resume(_timer);
}
@end

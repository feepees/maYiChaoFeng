//
//  RegisterViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+Extension.h"
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworldTextField;
@property (weak, nonatomic) IBOutlet UITextField *concerPWDField;
@property (weak, nonatomic) IBOutlet UITextField *invatedCodeTextField;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)dispatch_source_t  timer;
@end

@implementation RegisterViewController
- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerAction:(id)sender {
    
    NSMutableDictionary *paramet=[NSMutableDictionary dictionary];
    paramet[@"username"]=self.phoneNumberTextField.text;
    paramet[@"password"]=self.passworldTextField.text;
    paramet[@"password2"]=self.concerPWDField.text;
    paramet[@"nickname"]=self.nickNameTextFiled.text;
    if (self.invatedCodeTextField.text) {
        paramet[@"code"]=self.invatedCodeTextField.text;
    }
    NSLog(@"paramet:dic%@",paramet);
    [MJHttpTool Post:Regist parameters:paramet success:^(id responseObject) {
        NSLog(@"注册返回：%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [YJProgressHUD showSuccess:@"注册成功" inview:self.view];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"注册失败信息：%@",error);
        [YJProgressHUD showSuccess:@"注册失败" inview:self.view];

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nickNameTextFiled.imageName=@"dlzc_nc_icon";
    self.phoneNumberTextField.imageName=@"dlzc_sjhm_icon";
    self.verificationTextField.imageName=@"dlzc_yzm_icon";
    self.passworldTextField.imageName=@"dlzc_mm_icon";
    self.concerPWDField.imageName=@"dlzc_mm_icon";
    self.invatedCodeTextField.imageName=@"dlzc_mm_icon";

    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [_leftBtn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.verificationTextField.rightView=_leftBtn;
    self.verificationTextField.rightViewMode=UITextFieldViewModeAlways;
}
//获取验证码
-(void)getVerificationCode:(UIButton *)sender{
    sender.enabled=NO;
    __block int secend =10;
    int vrCode = (arc4random()%8999)+1000;
    NSLog(@"验证码是%d",vrCode);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (secend==0) {
            sender.enabled=YES;
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftBtn setTitle:@"重试"forState:UIControlStateNormal];
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftBtn setTitle:[NSString stringWithFormat:@"%d秒后重试",secend]forState:UIControlStateNormal];
            });
            secend--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

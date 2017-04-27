//
//  SettingNewPassworldViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "SettingNewPassworldViewController.h"
#import "UserModel.h"
@interface SettingNewPassworldViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passworldTextField;
@property (weak, nonatomic) IBOutlet UITextField *concernPassworldTextField;

@end

@implementation SettingNewPassworldViewController
- (IBAction)nextBtn:(id)sender {
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"username"]=@"111111";//self.mobile;
    parameter[@"password"]=self.passworldTextField.text;
    parameter[@"password2"]=self.concernPassworldTextField.text;
    MYLog(@"修改密码API%@parameter%@",ResetPsaaword,parameter);
    [MJHttpTool Post:ResetPsaaword parameters:parameter success:^(id responseObject) {
        MYLog(@"修改密码返回：%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            
            [YJProgressHUD showSuccess:@"更新成功" inview:self.view];
        }
    } failure:^(NSError *error) {
        MYLog(@"修改密码错误：%@",error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

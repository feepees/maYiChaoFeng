//
//  UpdataEmailViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UpdataEmailViewController.h"
#import "UserModel.h"
@interface UpdataEmailViewController ()
@property(nonatomic,strong)UITextField *emailTF;
@end

@implementation UpdataEmailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
         self.title=@"更改邮箱";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn addTarget:self action:@selector(updataEmail:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=leftItem;
    self.emailTF=[[UITextField alloc] initWithFrame:CGRectMake(Pading, 10, screenWidth-2*Pading, controlHeight)];
    self.emailTF.placeholder=@"请输入邮箱";
    self.emailTF.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.emailTF];
    
}
-(void)updataEmail:(UIButton *)sender{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    UserModel *user=[UserModel sharedUserModel];
    parameter[@"user_id"]=user.user_id;
    parameter[@"key"]=@"email";
    parameter[@"value"]=self.emailTF.text;
    MYLog(@"API:%@parameter:%@",UpdataProfile,parameter);
    [MJHttpTool Post:UpdataProfile parameters:parameter success:^(id responseObject) {
        MYLog(@"更改邮箱响应：%@",responseObject);
        [UserDataTool getUserProfile];
        [YJProgressHUD showSuccess:@"更新成功" inview:self.view];
    } failure:^(NSError *error) {
        MYLog(@"更改邮箱错误：%@",error);
        [YJProgressHUD showMessage:@"更新失败" inView:self.view];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

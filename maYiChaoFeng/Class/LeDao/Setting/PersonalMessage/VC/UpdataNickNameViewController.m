//
//  UpdataNickNameViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/30.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UpdataNickNameViewController.h"
#import "UserModel.h"
@interface UpdataNickNameViewController ()
@property(nonatomic,strong)UITextField *nickNameField;
@end

@implementation UpdataNickNameViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"更改昵称";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn addTarget:self action:@selector(updataNickname:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=leftItem;
    self.nickNameField=[[UITextField alloc] initWithFrame:CGRectMake(Pading, 10, screenWidth-2*Pading, controlHeight)];
    self.nickNameField.placeholder=@"请输入不多于6位昵称";
    self.nickNameField.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.nickNameField];
    
}
-(void)updataNickname:(UIButton *)sender{
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    UserModel *user=[UserModel sharedUserModel];
    parameter[@"user_id"]=user.user_id;
    parameter[@"key"]=@"nickname";
    parameter[@"value"]=self.nickNameField.text;
    MYLog(@"更改昵称：API:%@ parameter:%@",UpdataProfile,parameter);
    [MJHttpTool Post:UpdataProfile parameters:parameter success:^(id responseObject) {
        MYLog(@"更改昵称响应：%@",responseObject);
        [UserDataTool getUserProfile];
        [YJProgressHUD showSuccess:@"更新成功" inview:self.view];

    } failure:^(NSError *error) {
        MYLog(@"更改昵称错误：%@",error);
        [YJProgressHUD showMessage:@"更新失败" inView:self.view];
    }];
    
}

@end

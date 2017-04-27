//
//  BindingNewPhoneNumViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "BindingNewPhoneNumViewController.h"
#import "UserModel.h"
@interface BindingNewPhoneNumViewController ()
@property(nonatomic,strong) UITextField *phoneNumberTF;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation BindingNewPhoneNumViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"绑定手机";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(Pading, 0, self.view.frame.size.width-Pading*2, controlHeight)];
    label.text=@"请验证手机修改";
    [self.view addSubview:label];
    
    self.phoneNumberTF=[[UITextField alloc] initWithFrame:CGRectMake(Pading, 50, self.view.frame.size.width-30, controlHeight)];
    self.phoneNumberTF.placeholder=@"请输手机号码";
    self.phoneNumberTF.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:self.phoneNumberTF];
    
    
    UITextField *verificationNumberTF=[[UITextField alloc] initWithFrame:CGRectMake(Pading, 120, self.view.frame.size.width-Pading*2, controlHeight)];
    verificationNumberTF.placeholder=@"请输入验证码";
    verificationNumberTF.borderStyle=UITextBorderStyleRoundedRect;
   self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, controlHeight)];
    [_leftBtn addTarget:self action:@selector(getVRcode:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    verificationNumberTF.rightView=_leftBtn;
    verificationNumberTF.rightViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:verificationNumberTF];

    //提交
    UIButton *nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(Pading, 190, self.view.frame.size.width-Pading*2, controlHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"dlzc_an_bj"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

}
-(void)getVRcode:(UIButton *)sender{
    
    sender.enabled=NO;
    __block int secend =10;
    int vrCode = (arc4random()%8999)+1000;
    NSLog(@"验证码是%d",vrCode);
     _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
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
            secend--;
        });

        }

    });
    
    dispatch_resume(_timer);

}
-(void)next:(UIButton *)sender{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    UserModel *user=[UserModel sharedUserModel];
    parameter[@"user_id"]=user.user_id;
    parameter[@"key"]=@"mobile";
    parameter[@"value"]=self.phoneNumberTF.text;
    MYLog(@"更改手机API：%@参数：%@",UpdataProfile,parameter);
    [MJHttpTool Post:UpdataProfile parameters:parameter success:^(id responseObject) {
        MYLog(@"更改手机：%@",responseObject);
        [UserDataTool getUserProfile];
        [YJProgressHUD showSuccess:@"更新成功" inview:self.view];
    } failure:^(NSError *error) {
        MYLog(@"更改手机号码%@",error);
        [YJProgressHUD showMessage:@"更新失败" inView:self.view];
    }];
}



@end

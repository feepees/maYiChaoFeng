//
//  LoginViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPaasworldViewController.h"
#import "MYTabBarViewController.h"
#import "MYNavigationViewController.h"
#import "UITextField+Extension.h"
#import "UserModel.h"
#import <UMSocialCore/UMSocialCore.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumbertextFild;
@property (weak, nonatomic) IBOutlet UITextField *passWorldTextfiled;

@end

@implementation LoginViewController
-(UITabBarController *)setTabBarC{
    
    
    return [[MYTabBarViewController alloc]init];
}
//关闭按钮
- (IBAction)closeBten:(id)sender {
}

//登陆按钮
- (IBAction)loginBtn:(id)sender {
    
    if ([self.phoneNumbertextFild.text isEqualToString:@""]|[self.passWorldTextfiled.text isEqualToString:@""]) {
        [YJProgressHUD showMsgWithoutView:@"账号或密码不能为空"];
        return;
    }
    //[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.phoneNumbertextFild.text] forKey:@"userName"];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"username"]=self.phoneNumbertextFild.text;
    dic[@"password"]=self.passWorldTextfiled.text;
    [MJHttpTool Post:Login parameters:dic success:^(id responseObject) {
        MYLog(@"返回数据%@",responseObject);
        //状态码0000表示登陆成功
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            
            [self presentViewController:[self setTabBarC] animated:YES completion:nil];
            //字典转模型
            UserModel *model=[UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            //归档
            [NSKeyedArchiver archiveRootObject:model toFile:UserData];
        }

    } failure:^(NSError *error) {
        NSLog(@"登陆错误：%@",error);
    }];
}

//注册按钮
- (IBAction)registerBtn:(id)sender {
    RegisterViewController *registerC=[[RegisterViewController alloc]init];
    [self presentViewController:registerC animated:YES completion:nil];
    
}

//忘记密码按钮
- (IBAction)forgetPassworldBten:(id)sender {
    
    ForgetPaasworldViewController *forgetC=[[ForgetPaasworldViewController alloc]init];
    forgetC.title=@"忘记密码";
    
    [self.navigationController pushViewController:forgetC animated:YES];

}

//QQ登陆按钮
- (IBAction)qq_loginBtn:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

//微信登陆按钮
- (IBAction)wx_loginBtn:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

//微博登陆按钮
- (IBAction)xl_loginBtn:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}
//第三方登陆
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    NSLog(@"hahahhah");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        NSLog(@"hahahha");
        // 第三方平台SDK原始数据
        MYPLog(@" originalResponse: %@", resp.originalResponse);
        
        //登陆
        NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
        parameter[@"openid"]=resp.uid;
        switch (platformType) {
            case UMSocialPlatformType_Sina:
                parameter[@"oauth"]=@"wb";
                break;
            case UMSocialPlatformType_WechatSession:
                parameter[@"oauth"]=@"wx";
                break;
            case UMSocialPlatformType_QQ:
                parameter[@"oauth"]=@"qq";
                break;
            default:
                break;
        }
        
        parameter[@"nickname"]=resp.name;
        parameter[@"head_pic"]=resp.iconurl;
        MYPLog(@"三方登陆API%@parameter%@",PlatformLogin,parameter);
        [MJHttpTool Post:PlatformLogin parameters:nil success:^(id responseObject) {
            MYPLog(@"三方登陆返回：%@",responseObject);
            if([responseObject[@"code"] isEqualToString:@"0000"]){
                [self presentViewController:[self setTabBarC] animated:YES completion:nil];}
        } failure:^(NSError *error) {
            MYPLog(@"三方登陆错误：%@",error);
        }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumbertextFild.imageName=@"dlzc_nc_icon";
    self.passWorldTextfiled.imageName=@"dlzc_mm_icon";
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}
//收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.editing=NO;
}


@end

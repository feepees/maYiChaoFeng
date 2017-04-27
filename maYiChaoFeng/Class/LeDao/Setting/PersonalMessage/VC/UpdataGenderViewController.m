//
//  UpdataGenderViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UpdataGenderViewController.h"
#import "UserModel.h"
@interface UpdataGenderViewController ()
@property(nonatomic,strong)UIButton *manBtn;
@property(nonatomic,strong)UIButton *womanBtn;
@property(nonatomic,copy)NSString *genderCode;
@end

@implementation UpdataGenderViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
         self.title=@"更改性别";
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.genderCode=@"1";
    
    [self setUI];
}

-(void)commitAction:(UIButton *)sender{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"key"]=@"sex";
    parameter[@"value"]=self.genderCode;
    [MJHttpTool Post:UpdataProfile parameters:parameter success:^(id responseObject) {
        MYLog(@"更改性别返回：%@",responseObject);
        [UserDataTool getUserProfile];
        [YJProgressHUD showSuccess:@"更新成功" inview:self.view];
    } failure:^(NSError *error) {
        MYLog(@"更改性别错误%@",error);
        [YJProgressHUD showMessage:@"更新失败" inView:self.view];
    }];
}
-(void)setUI{
    
    UILabel *manLable=[[UILabel alloc]initWithFrame:CGRectMake(Pading, 25, 30, 30)];
    manLable.text=@"男";
    [self.view addSubview:manLable];
    
    self.manBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 25, 30, 30)];
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"ggxb_normal"] forState:UIControlStateSelected];
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"ggxb_selected"] forState:UIControlStateNormal ];
    _manBtn.selected=YES;
    [_manBtn addTarget:self action:@selector(manBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_manBtn];

    UIView *manLine=[[UIView alloc]initWithFrame:CGRectMake(Pading, 65, screenWidth-Pading*2, 1)];
    manLine.backgroundColor=[UIColor blackColor];
    [self.view addSubview:manLine];
    
    
    
    UILabel *womanLable=[[UILabel alloc]initWithFrame:CGRectMake(Pading, 75, 30, 30)];
    womanLable.text=@"女";
    [self.view addSubview:womanLable];
    
    self.womanBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 75, 30, 30)];
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"ggxb_normal"] forState:UIControlStateSelected];
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"ggxb_selected"] forState:UIControlStateNormal ];
    [_womanBtn addTarget:self action:@selector(womanBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _womanBtn.selected=NO;
    [self.view addSubview:_womanBtn];
    
    UIView *womanLine=[[UIView alloc]initWithFrame:CGRectMake(Pading, 115, screenWidth-Pading*2, 1)];
    womanLine.backgroundColor=[UIColor blackColor];
    [self.view addSubview:womanLine];
    
    
    
}

-(void)manBtnAction:(UIButton *)sender{
    self.womanBtn.selected=NO;
    self.genderCode=@"1";
    sender.selected=YES;
}

-(void)womanBtnAction:(UIButton *)sender{

    self.manBtn.selected=NO;
    self.genderCode=@"2";
    sender.selected=YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end

//
//  AddNewAddressViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "AddNewAddressViewController.h"
#import "JFCityViewController.h"
@interface AddNewAddressViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneLable;
@property (weak, nonatomic) IBOutlet UITextView *detailAddressLable;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLable;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

@property(nonatomic,copy)NSString *isDefault;
@end

@implementation AddNewAddressViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"新增收货地址";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_model) {
        self.nameTextField.text=_model.name;
        self.phoneLable.text=_model.mobile;
        self.detailAddressLable.text=_model.address;

    }
    if (self.detailAddressLable.text.length>0) {
        self.placeHolderLable.hidden=YES;
    }
    else{
        self.placeHolderLable.hidden=NO;
    }
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=BACKGROUNDCOLOR;
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [rightBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.detailAddressLable.delegate=self;
    
}

-(void )submitAction:(UIButton *)sender{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"name"]=self.nameTextField.text;
    parameter[@"mobile"]=self.phoneLable.text;
    parameter[@"region"]=self.cityBtn.titleLabel.text;
    parameter[@"address"]=self.detailAddressLable.text;
    parameter[@"is_default"]=self.isDefault;
    MYLog(@"添加寄送地址接口:%@参数：%@",AddAddress,parameter);
[MJHttpTool Post:AddAddress parameters:parameter success:^(id responseObject) {
    MYLog(@"添加寄送地址返回：%@",responseObject);
    if ([responseObject[@"code"] isEqualToString:@"0000"]) {
        [YJProgressHUD showSuccess:@"添加成功" inview:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }
} failure:^(NSError *error) {
    MYLog(@"添加寄送地址错误%@",error);
    [YJProgressHUD showMessage:@"添加失败" inView:self.view];
}];
}

- (IBAction)setDefaultAction:(id)sender {
    UIButton *button=(UIButton *)sender;
    button.selected=!button.selected;
    self.isDefault=button.selected?@"1":@"0";
}
- (IBAction)selectCityAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    JFCityViewController *cityC=[[JFCityViewController alloc]init];
    cityC.title=@"选择城市";
    [cityC choseCityBlock:^(NSString *cityName) {
        [btn setTitle:cityName forState:UIControlStateNormal];
        NSLog(@"%@",cityName);
    }];
    [self.navigationController pushViewController:cityC animated:YES];
    
}
#pragma mark --------------------------UITextViewDelegate--------------------
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0){
        self.placeHolderLable.hidden=YES;
    }
    else{
        self.placeHolderLable.hidden=NO;
    }
}
@end

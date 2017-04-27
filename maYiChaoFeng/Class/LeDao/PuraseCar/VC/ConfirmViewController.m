//
//  ConfirmViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "ConfirmViewController.h"
#import "GoodsInformationTableViewCell.h"
#import "ConfirmOrderHeadView.h"
#import "OrderAddressTableViewCell.h"
#import "SelectAdressViewController.h"
#import "AddressModel.h"
#import <Masonry.h>
@interface ConfirmViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AddressModel *model;
@property(nonatomic,strong)UILabel *placeHolder;
@end

@implementation ConfirmViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"确认订单";
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsInformationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderAddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId1"];
        
        UITextView *messageView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, screenHeight, 300)];
        self.placeHolder=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        self.placeHolder.text=@"买家留言";
        messageView.delegate=self;
        [messageView addSubview:self.placeHolder];
        _tableView.tableFooterView=messageView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setUpFooter];
    [self getDefauleAddress];
}
-(void)setUpFooter{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, screenHeight-114, screenWidth, 50)];
    UILabel *totalLable=[[UILabel alloc]init];
    totalLable.text=@"合计:";
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(15,10, screenWidth-115, 30)];
    lable.textAlignment=NSTextAlignmentRight;
    double totalPrice=0.0;
    for (CartModel *model in self.dataSource) {
        totalPrice+=model.total.doubleValue;
    }
    lable.text=[NSString stringWithFormat:@"￥%.2f",totalPrice];
    lable.textColor=[UIColor redColor];
    lable.font=[UIFont systemFontOfSize:20];
    
    UIButton *button=[[UIButton alloc]init];
    [button addTarget: self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor redColor];
    
    [footerView addSubview:totalLable];
    [footerView addSubview:lable];
    [footerView addSubview:button];
    [self.view addSubview:footerView];
    
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView);
        make.centerY.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button.mas_left);
        make.centerY.equalTo(footerView);
        make.height.mas_equalTo(30);
    }];
    [totalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lable.mas_left);
        make.centerY.equalTo(footerView);
        make.height.mas_equalTo(30);
    }];
    
    
}
-(void)submitOrder:(UIButton *)sender{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    NSMutableString *str=[[NSMutableString alloc]init];
    double total=0.0;
    for (CartModel *model in self.dataSource) {
        [str appendString:model.Id];
        [str appendString:@","];
        total+=model.total.doubleValue;
    }
    [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    parameter[@"cart_id"]=str;
    parameter[@"price"]=[NSString stringWithFormat:@"%f",total];
    parameter[@"address_id"]=self.model.Id;
    parameter[@"user_money"]=[UserModel sharedUserModel].user_money;
    MYLog(@"提交订单接口:%@参数：%@",AddOrder,parameter);
[MJHttpTool Post:AddOrder parameters:parameter success:^(id responseObject) {
    MYLog(@"提交订单返回%@",responseObject);
} failure:^(NSError *error) {
    MYLog(@"提交订单错误%@",error);
}];
}
-(void)getDefauleAddress{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
[MJHttpTool Post:GetDefaultAddreess parameters:parameter success:^(id responseObject) {
    MYLog(@"获取默认地址返回啊：%@",responseObject);
  self.model=  [AddressModel mj_objectWithKeyValues:responseObject[@"data"]];
    [self.tableView reloadData];
} failure:^(NSError *error) {
    MYLog(@"获取默认地址错误%@",error);
}];
}
#pragma mark -------------UITextVIewDelegate-----------------
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length<1) {
        self.placeHolder.hidden=NO;
        
    }
    else{
        self.placeHolder.hidden=YES;
    }
}
#pragma mark -------------UITableViewdelegate----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
        return self.dataSource.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellId1";
       OrderAddressTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (self.model) {
            cell.model=self.model;
        }
        
        cell.selectAddresAction=^{
            SelectAdressViewController *selectC=[[SelectAdressViewController alloc]init];
            selectC.returnAddress=^(AddressModel *model){
                self.model=model;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:selectC animated:YES];
        };
        return cell;
    }
    else{
    static NSString *cellId=@"cellId";
    GoodsInformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=self.dataSource[indexPath.item];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        return 105;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 17, 16)];
        imageView.image=[UIImage imageNamed:@"iconfont-banshizhinan"];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(47, 10, 100, 16)];
        lable.text=@"产品详情";
        [headView addSubview:imageView];
        [headView addSubview:lable];
        return headView;
    }
    else{
    
        return nil;
    }
}

@end

//
//  PurchaseCarViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "PurchaseCarViewController.h"
#import "PurhaseTableViewCell.h"
#import "CartModel.h"
#import <Masonry.h>
#import "ConfirmViewController.h"
#import "UIView+FPErrorPage.h"
@interface PurchaseCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)UILabel *totalPriceLable;
@property(nonatomic,strong)NSMutableArray *selectedArray;

@property(nonatomic,assign)BOOL isSelectedAll;
@end

@implementation PurchaseCarViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"PurhaseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
-(NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [[NSMutableArray alloc]init];
        
    }
    return _selectedArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getdata];
    [self setUpPlaceOrderViwe];
    self.isSelectedAll=NO;
}
-(void)setUpPlaceOrderViwe{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, screenHeight-114, screenWidth, 50)];
    view.backgroundColor=[UIColor whiteColor];
    UIButton *selectBtn=[[UIButton alloc]init];
    [selectBtn addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"gwc_xz_normal"] forState:UIControlStateNormal];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"gwc_xz_selected"] forState:UIControlStateSelected];
    [view addSubview:selectBtn];
    UILabel *label=[[UILabel alloc]init];
    label.text=@"全选";
    [view addSubview:label];
    
    UILabel *totalLable=[[UILabel alloc]init];
    totalLable.text=@"合计:";
    [view addSubview:totalLable];
    
    self.totalPriceLable=[[UILabel alloc]init];
    _totalPriceLable.text= @"￥0.0";
    [view addSubview:_totalPriceLable];
    
    UIButton *submitBtn=[[UIButton alloc]init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor=[UIColor redColor];
    [view addSubview:submitBtn];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectBtn.mas_right);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(20);
    }];
    [_totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(submitBtn.mas_left).offset(-30);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(20);
    }];
    [totalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_totalPriceLable.mas_left);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(20);
    }];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(115, 50));
    }];
    [self.view addSubview:view];
    

}
-(void)submitAction:(UIButton *)sender{
    ConfirmViewController *confirmC=[[ConfirmViewController alloc]init];
    confirmC.dataSource=self.selectedArray;
    [self.navigationController pushViewController:confirmC animated:YES];
}
-(void)selectAllAction:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected) {
        [self.selectedArray removeAllObjects];
        [self.dataSoure enumerateObjectsUsingBlock:^(CartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.is_selected=@"1";
            [self.selectedArray addObject:obj];
        }];
        self.isSelectedAll=YES;
        [self.tableView reloadData];
        [self countTotalPrice];
    }
    else{
        for (CartModel *model in self.selectedArray) {
            model.is_selected=@"0";
        }
        [self.selectedArray removeAllObjects];
        self.isSelectedAll=NO;
        [self.tableView reloadData];
        [self countTotalPrice];
    }
}
-(void)reloadSelectDataSoure{
    [self.selectedArray enumerateObjectsUsingBlock:^(CartModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (CartModel *model in self.dataSoure) {
            
            if (obj.Id==model.Id) {
                model.is_selected=obj.is_selected;
                [self.selectedArray replaceObjectAtIndex:idx withObject:model];
            }
        }
    }];
    [self countTotalPrice];
}
-(void)countTotalPrice{
    double total=0.0;
    for (CartModel *model in self.selectedArray) {
        total+=model.total.doubleValue;
    }
    self.totalPriceLable.text=[NSString stringWithFormat:@"￥%.2f",total];
}
-(void)getdata{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    MYLog(@"请求购物车数据接口:%@参数:%@",GetCart,parameter);
    [MJHttpTool Post:GetCart parameters:parameter success:^(id responseObject) {
        MYLog(@"购物车返回：%@",responseObject);
        self.dataSoure =[CartModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        UILabel *titleView=(UILabel *) self.navigationItem.titleView;
        titleView.text=[NSString stringWithFormat:@"购物车(%ld)",self.dataSoure.count];
        if (self.dataSoure.count<1) {
            [self.tableView showBlankPageView];
        }
        else{
            [self.tableView hideBlankPageView];
        }
        [self.tableView reloadData];
        [self reloadSelectDataSoure];
    } failure:^(NSError *error) {
        MYLog(@"购物车返回错误%@",error);
    }];
}
-(void)deleteGoodsWithModel:(CartModel *)model{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=model.user_id;
    parameter[@"goods_id"]=model.goods_id;
    [MJHttpTool Post:DeleteCart parameters:parameter success:^(id responseObject) {
        MYLog(@"删除购物车返回%@",responseObject);
        if([responseObject[@"code"] isEqualToString:@"0000"]){
            [YJProgressHUD showSuccess:@"删除成功" inview:self.view];
            [self.selectedArray removeObject:model];
            [self getdata];
        }
    } failure:^(NSError *error) {
        MYLog(@"删除购物车失败%@",error);
    }];
}
-(void)updataGoodsWithModel:(CartModel *)model{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=model.user_id;
    parameter[@"goods_id"]=model.goods_id;
    parameter[@"goods_num"]=model.goods_num;
    [MJHttpTool Post:UpdataCart parameters:parameter success:^(id responseObject) {
        MYLog(@"更新购物车返回%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [self getdata];
        }
    } failure:^(NSError *error) {
        MYLog(@"更新购物车失败%@",error);
    }];
}

#pragma  mark -------------UITableViewDelegate------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    PurhaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.goodsSelected=self.isSelectedAll;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.deleteAction=^(CartModel *model){
        
        [self deleteGoodsWithModel:model];
    };
    cell.doneAction=^(CartModel * model){
        [self updataGoodsWithModel:model];
    };
    cell.selectAction=^(CartModel *model,BOOL isSelect){
        if (isSelect) {
            model.is_selected=@"1";
            if (![self.selectedArray containsObject:model]) {
                [self.selectedArray addObject:model];
            }
        }
        else{
            
            if ([self.selectedArray containsObject:model]) {
                [self.selectedArray removeObject:model];
            }
        }
        
        [self countTotalPrice];
    };
    cell.model=self.dataSoure[indexPath.section];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}
@end

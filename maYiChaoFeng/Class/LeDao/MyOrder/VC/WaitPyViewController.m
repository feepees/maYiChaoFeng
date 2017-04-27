//
//  WaitPyViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "WaitPyViewController.h"
#import "WaitPayTableViewCell.h"
#import "GoodsOrderModel.h"
#import "OrderDataTool.h"
#import "UIView+FPErrorPage.h"
@interface WaitPyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)NSMutableArray *selectedArray;
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UIView *mergeView;
@end

@implementation WaitPyViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 164, 0);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"WaitPayTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        
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
    self.title=@"商品详情";
    [self.view addSubview:self.tableView];
    [self getDataWithPage:@"0"];
    [self setUpMregePayView];
    

    
}

-(void)setUpMregePayView{
    self.mergeView=[[UIView alloc]initWithFrame:CGRectMake(0, screenHeight-164, screenWidth, 50)];
    self.mergeView.backgroundColor=[UIColor whiteColor];
    self.total=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth-300, 0, 200, 50)];
    _total.textAlignment=NSTextAlignmentRight;
    _total.textColor=[UIColor redColor];
    [_mergeView addSubview:_total];
    
    UIButton *mergeBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenWidth-100, 0, 100, 50)];
    [mergeBtn addTarget:self action:@selector(mergePayAction:) forControlEvents:UIControlEventTouchUpInside];
    [mergeBtn setTitle:@"合并付款" forState:UIControlStateNormal];
    [mergeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mergeBtn.backgroundColor=[UIColor redColor];
    [_mergeView addSubview:mergeBtn];
    [self.view addSubview:_mergeView];
    //
    self.mergeView.hidden=YES;
}
-(void)mergePayAction:(UIButton *)sender{

}
-(void)getDataWithPage:(NSString *)page{
    
    [OrderDataTool getOrderWithStatus:@"0" page:page success:^(id responseObject) {
        //MYLog(@"获取待付款订单列表返回%@",responseObject);
        self.dataSoure= [GoodsOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        if (self.dataSoure.count==0) {
            [self.tableView showBlankPageView];
        }
        else{
            [self.tableView hideBlankPageView];
        }
    } failure:^(NSError *error) {
        MYLog(@"获取待付款订单列表错误%@",error);
    }];
}
-(void)deleteOrderWithModel:(GoodsOrderModel *)model{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"order_id"]=model.order_id;
    MYLog(@"删除订单接口%@参数%@",DeleteOrder,parameter);
    [MJHttpTool Post:DeleteOrder parameters:parameter success:^(id responseObject) {
        MYLog(@"删除订单返回%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [YJProgressHUD showSuccess:@"删除成功" inview:self.view];
            [self getDataWithPage:@"0"];
        }
    } failure:^(NSError *error) {
        MYLog(@"删除订单错误%@",error);
    }];
}
-(void)countTotal{
    double total=0.0;
    for (GoodsOrderModel *model in self.selectedArray) {
        total+=model.order_amount.doubleValue;
    }
    self.total.text=[NSString stringWithFormat:@"￥%.2f",total];
}
#pragma mark ----------------------UITableViewDelegate--------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    WaitPayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataSoure[indexPath.section];
    cell.cancalOrder=^(GoodsOrderModel *model){
        [self deleteOrderWithModel:model];
    };
    cell.selectOrder=^(GoodsOrderModel *model,BOOL isSelect){
        if (isSelect) {
            if (![self.selectedArray containsObject:model]) {
                [self.selectedArray addObject:model];
            }
        }
        else{
            
            if ([self.selectedArray containsObject:model]) {
                [self.selectedArray removeObject:model];
            }
        }
        if (self.selectedArray.count>1) {
            [self countTotal];
            self.mergeView.hidden=NO;
        }
        else{
            self.mergeView.hidden=YES;
        }
        
    };

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsOrderModel *model=self.dataSoure[indexPath.section];
    return 64+(80*model.goods.count);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end

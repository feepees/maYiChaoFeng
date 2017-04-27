//
//  RankListViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  排行榜

#import "RankListViewController.h"
#import "RankTableViewCell.h"
#import "RankFirstTableViewCell.h"
#import "MenmberModel.h"

@interface RankListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation RankListViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"RankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        [_tableView registerNib:[UINib nibWithNibName:@"RankFirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellID"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getData];
}
-(void)getData{
    
    [MJHttpTool GET:RankList parameters:nil success:^(id responseObject) {
        MYLog(@"排行榜返回：%@",responseObject);
        self.dataSoure=[MenmberModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MYLog(@"排行榜错误：%@",error);
    }];
}
#pragma mark ------------UITableViewDelegate-------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        RankFirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=self.dataSoure[indexPath.item];
        return cell;
    }
    else{
    static NSString *cellId=@"cellId";
    RankTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        [cell.rankView setTitle:[NSString stringWithFormat:@"NO.%ld",indexPath.item+1] forState:UIControlStateNormal];
        if (indexPath.item==1) {
            [cell.rankView setBackgroundImage:[UIImage imageNamed:@"phb_bj_no2"] forState:UIControlStateNormal];
            cell.moneyView.image=[UIImage imageNamed:@"phb_jf_no2_icon"];
        }
        else if(indexPath.item==2){
        [cell.rankView setBackgroundImage:[UIImage imageNamed:@"phb_bj_no3"] forState:UIControlStateNormal];
            cell.moneyView.image=[UIImage imageNamed:@"phb_jf_no3_icon"];
        }
        else{
            [cell.rankView setBackgroundImage:[UIImage imageNamed:@"phb_bj_hui"] forState:UIControlStateNormal];
            cell.moneyView.image=[UIImage imageNamed:@"phb_jf_icon"];

        }
    cell.RankNum.text=@"23333";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataSoure[indexPath.item];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        return 130;
    }
    
    return 60;
}


@end

//
//  LeXiangTableViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LeXiangTableViewController.h"
#import "LXHeadView.h"
#import "LeXiangTableViewCell.h"
#import "GoodsModel.h"
#import "BannerModel.h"
#import "GoodsDetailViewController.h"
#import <MJRefresh.h>

@interface LeXiangTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) LXHeadView *headView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)NSMutableArray *bannerDataSoure;
@property(nonatomic,copy)NSString *page;
@end

static NSString *headerViewIdentifier = @"LXHeadView";

@implementation LeXiangTableViewController

-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
-(NSMutableArray *)bannerDataSoure{
    if (!_bannerDataSoure) {
        _bannerDataSoure = [[NSMutableArray alloc]init];
        
    }
    return _bannerDataSoure;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"LeXiangTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
    }
    return _tableView;
}- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=@"0";
        [self getDataWithPage:self.page];
    }];
    self.tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        NSInteger page=self.page.integerValue;
        page++;
        self.page=[NSString stringWithFormat:@"%ld",page];
        [self getDataWithPage:self.page];
    }];
    [self getDataWithPage:@"0"];
    [self getBannerData];
    
}
-(void)getDataWithPage:(NSString *)page{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"name"]=@"乐享";
    parameter[@"page"]=page;
    parameter[@"page_size"]=@"5";
[MJHttpTool Post:GoodsList parameters:parameter success:^(id responseObject) {
    //MYLog(@"获取商品列表返回%@",responseObject);
    if ([self.page isEqualToString:@"0"]) {
        self.dataSoure=[GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView.mj_header endRefreshing];
 
    }
    else{
        [self.dataSoure addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [self.tableView.mj_footer endRefreshing];
    }
        [self.tableView reloadData];
} failure:^(NSError *error) {
    MYLog(@"获取商品列表错误%@",error);
}];
}
-(void)getBannerData{
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"name"]=self.titleName;
    [MJHttpTool Post:BannerList parameters:parameter success:^(id responseObject) {
        //MYLog(@"广告数据返回：%@",responseObject);
        self.bannerDataSoure=[BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MYLog(@"广告数据错误：%@",error);
    }];
}
-(void)addToCartWith:(GoodsModel *)model{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"goods_id"]=model.a_id;
    parameter[@"goods_num"]=@"1";
    MYLog(@"添加购物车接口%@参数：%@",AddToCart,parameter);
        [MJHttpTool Post:AddToCart parameters:parameter success:^(id responseObject) {
            MYLog(@"立即购买购物车返回%@",responseObject);
            [YJProgressHUD showSuccess:@"添加成功" inview:self.view];
        }
         failure:^(NSError *error) {
             [YJProgressHUD showMessage:@"添加失败" inView:self.view];
             MYLog(@"立即购买购物车错误%@",error);
        }];
    

}
#pragma mark - Table view data source=
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoure.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
  LeXiangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataSoure[indexPath.item];
    cell.AddToCartAction=^{
        NSLog(@"xianbiao %ld",indexPath.item);
        [self addToCartWith:self.dataSoure[indexPath.item]];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailViewController *goodsC=[[GoodsDetailViewController alloc]init];
    GoodsModel *model=self.dataSoure[indexPath.item];
    goodsC.goodsId=model.a_id;
    goodsC.title=@"商品详情";
    [self.navigationController pushViewController:goodsC animated:YES];
}
//创建头视图
-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headView = [[LXHeadView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    
    self.headView.HeadViewBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
    };
    NSMutableArray *imagesUrlString=[NSMutableArray array];
    [self.bannerDataSoure enumerateObjectsUsingBlock:^(BannerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imagesUrlString addObject:[NSString stringWithFormat:@"%@%@",Host1,obj.pic]];
    }];
    self.headView.dataArray = imagesUrlString;
    return self.headView;

}

@end

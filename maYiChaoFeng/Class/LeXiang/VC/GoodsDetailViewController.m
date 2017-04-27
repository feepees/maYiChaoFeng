//
//  GoodsDetailViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "LXHeadView.h"
#import "BannerModel.h"
#import "GoodsDetailTableViewCell.h"
#import "GoodsCommentTableViewCell.h"
#import "AddPurchaseCarView.h"
#import "GoodSCommentViewController.h"
#import "ConfirmViewController.h"
#import "GoodsModel.h"
#import "CommentModel.h"
#import "CartModel.h"
#import <Masonry.h>
#import <UShareUI/UShareUI.h>

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property(nonatomic,strong)LXHeadView *headView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)NSMutableArray *bannerDataSoure;
@property(nonatomic,strong)CommentModel *commentModel ;
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)UIView *footerView;
@end

@implementation GoodsDetailViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsCommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId1"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId2"];
        
        
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
-(UIWebView *)web{
    if (!_web) {
        _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _web.scrollView.bounces=NO;
        _web.scalesPageToFit=YES;
        _web.delegate=self;
        _web.scrollView.delegate=self;
    }
    return _web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self.view addSubview:self.tableView];
    [self setUpPurchaseView];
    [self setRightItem];
    
}
-(void)setRightItem{
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"fx_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}
-(void)shareAction:(UIButton *)sender{

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareTextToPlatformType:platformType];
    }];
}
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

-(void)addToCartIsBuy:(BOOL)isBuy{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"goods_id"]=self.goodsId;
    parameter[@"goods_num"]=@"1";
    MYLog(@"添加购物车接口%@参数：%@",AddToCart,parameter);
    if (isBuy) {
    [MJHttpTool Post:UpdataCart parameters:parameter success:^(id responseObject) {
        MYLog(@"立即购买购物车返回%@",responseObject);
            CartModel *model=[CartModel mj_objectWithKeyValues:responseObject[@"data"]];
            ConfirmViewController *confirmC=[[ConfirmViewController alloc]init];
            NSMutableArray *array=[NSMutableArray array];
            [array addObject:model];
            confirmC.dataSource=array;
            [self.navigationController pushViewController:confirmC animated:YES];
        }
     failure:^(NSError *error) {
        
        MYLog(@"立即购买购物车错误%@",error);
    }];
    }
    else{
        [MJHttpTool Post:AddToCart parameters:parameter success:^(id responseObject) {
            MYLog(@"添加购物车返回%@",responseObject);
            [YJProgressHUD showSuccess:@"添加成功" inview:self.view];
                    }
                 failure:^(NSError *error) {
                     
                     MYLog(@"添加购物车错误%@",error);
                 }];
    }

}
-(void)setUpPurchaseView{
    self.footerView=[[UIView alloc]initWithFrame:CGRectMake(0, screenHeight-114, screenWidth, 50)];
    self.footerView.backgroundColor=[UIColor whiteColor];
    UIButton *catrBtn=[[UIButton alloc]init];
    catrBtn.imageEdgeInsets=UIEdgeInsetsMake(-20, 15, 0, 0);
    catrBtn.titleEdgeInsets=UIEdgeInsetsMake(20, -15, 0, 0);
    catrBtn.userInteractionEnabled=NO;
    [catrBtn setImage:[UIImage imageNamed:@"gwc_xiao"] forState:UIControlStateNormal];
    [catrBtn setTitle:@"购物车" forState:UIControlStateNormal];
    catrBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [catrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *buyBtn=[[UIButton alloc]init];
    [buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.backgroundColor=[UIColor redColor];
    
    UIButton *addToCartBtn=[[UIButton alloc]init];
    [addToCartBtn addTarget:self action:@selector(addToCartAction:) forControlEvents:UIControlEventTouchUpInside];
    [addToCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addToCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addToCartBtn.backgroundColor=[UIColor blackColor];
    
    [self.footerView addSubview:catrBtn];
    [self.footerView addSubview:buyBtn];
    [self.footerView addSubview:addToCartBtn];
    [self.view addSubview:self.footerView];
    
    [catrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 50));
        make.left.equalTo(_footerView);
        make.top.equalTo(_footerView);
        
    }];
    [addToCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buyBtn.mas_width);
        make.height.mas_equalTo(50);
        make.left.equalTo(catrBtn.mas_right);
        make.top.equalTo(_footerView);
        
    }];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buyBtn.mas_width);
        make.height.mas_equalTo(50);
        make.left.equalTo(addToCartBtn.mas_right);
        make.right.equalTo(_footerView);
        make.top.equalTo(_footerView);
        
    }];

}
-(void)buyAction:(UIButton *)sender{
    [self addToCartIsBuy:YES];
}
-(void)addToCartAction:(UIButton *)sender{
    [self addToCartIsBuy:NO];
}
-(void)getData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"a_id"]=self.goodsId;
    parameter[@"page"]=@"0";
    parameter[@"page_size"]=@"1";
[MJHttpTool Post:GoodDetail parameters:parameter success:^(id responseObject) {
    MYLog(@"商品详情返回:%@",responseObject);
    self.bannerDataSoure=responseObject[@"data"][@"images"];
    [self.dataSoure addObject:[GoodsModel mj_objectWithKeyValues:responseObject[@"data"]]];
    self.commentModel=[CommentModel mj_objectWithKeyValues:responseObject[@"data"][@"comment"][0]];
    [self.tableView reloadData];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/goods/app_info/a_id/%@.html",Host1,responseObject[@"data"][@"a_id"]]]]];
} failure:^(NSError *error) {
    MYLog(@"商品详情错误%@",error);
}];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    if (indexPath.item==0) {
        GoodsDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        if (self.dataSoure.count==1) {
            cell.model=self.dataSoure[0];
        }
        return cell;
    }
    if (indexPath.item==1) {
        GoodsCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId1" forIndexPath:indexPath];
        if (self.commentModel) {
            cell.model=self.commentModel;
        }
        cell.seeAllComment=^{
            GoodSCommentViewController *commentC=[[GoodSCommentViewController alloc]init];
            commentC.goodsId=self.goodsId;
            [self.navigationController pushViewController:commentC animated:YES];
            
        };
        return cell;
    }
    if (indexPath.item==2) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId2" forIndexPath:indexPath];
       
        [cell.contentView addSubview:self.web];
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        return 150;
    }
    if (indexPath.item==1) {
        return 260;
    }
    return screenHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}
//创建头视图

-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headView = [[LXHeadView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    
    self.headView.HeadViewBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
    };
    NSMutableArray *imagesUrlString=[NSMutableArray array];
    [self.bannerDataSoure enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imagesUrlString addObject:[NSString stringWithFormat:@"%@%@",Host1,obj[@"image_url"]]];
    }];
    self.headView.dataArray = imagesUrlString;
    return self.headView;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ((self.tableView.contentOffset.y<=self.tableView.contentSize.height-screenHeight)&&(self.web.scrollView.contentOffset.y==0)) {
        self.web.scrollView.scrollEnabled=NO;
    }
    else{
        self.web.scrollView.scrollEnabled=YES;
    }

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView==self.web.scrollView && self.web.scrollView.contentOffset.y==0) {
        self.web.scrollView.scrollEnabled=NO;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}


@end

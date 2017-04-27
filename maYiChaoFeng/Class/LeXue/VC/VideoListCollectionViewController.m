//
//  VideoListCollectionViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "VideoListCollectionViewController.h"
#import "LXHeadView.h"
#import "VideoListCollectionViewCell.h"
#import "MoviePlayerViewController.h"
#import "ArticleModel.h"
#import <MJRefresh.h>
#import "BannerModel.h"
@interface VideoListCollectionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) LXHeadView *headView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)NSMutableArray *bannerDataSoure;

@property(nonatomic,assign)NSInteger page;

@end

@implementation VideoListCollectionViewController

static NSString * const reuseIdentifier = @"VideoListCollectionViewCell";
static NSString *headerViewIdentifier = @"LXHeadView";


- (instancetype)init {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 10;
    flow.minimumInteritemSpacing =10;
    CGFloat width = (screenWidth-30)/2 - 0.1;
    flow.itemSize = CGSizeMake(width,200);
    self = [self initWithCollectionViewLayout:flow];
    if (self) {
        // insert code here...
    }
    return self;
}

-(NSMutableArray *)bannerDataSoure{
    if (!_bannerDataSoure) {
        _bannerDataSoure = [[NSMutableArray alloc]init];
        
    }
    return _bannerDataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.page=0;
    //注册头视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        
        self.page=0;
        [self getDatapage:0];
        
    }];
    self.collectionView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉刷新");
        self.page++;
        [self getDatapage:self.page];
    }];
    //请求广告数据
    [self getBannerData];
    //请求数据
    [self getDatapage:0];
}
//请求广告数据
-(void)getBannerData{
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"name"]=self.titleName;
    [MJHttpTool Post:BannerList parameters:parameter success:^(id responseObject) {
        //MYLog(@"广告数据返回：%@",responseObject);
        self.bannerDataSoure=[BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    } failure:^(NSError *error) {
        MYLog(@"广告数据错误：%@",error);
    }];
}
//获取数据
-(void)getDatapage:(NSInteger)page{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"name"]=self.titleName;
    parameter[@"page"]=[NSString stringWithFormat:@"%ld",page];
    parameter[@"page_size"]=@"4";
    [MJHttpTool Post:GetArticle parameters:parameter success:^(id responseObject) {
        //MYLog(@"获取%@文章返回数据：%@",self.titleName,responseObject);
        if(self.page==0){
            self.dataSoure=  [ArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionView.mj_header endRefreshing];
        }
        else
        {
            [self.dataSoure addObjectsFromArray:[ArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            [self.collectionView.mj_footer endRefreshing];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        MYLog(@"获取%@文章失败：%@",self.titleName,error);
    }];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSoure.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  

    //在这里注册自定义的XIBcell否则会提示找不到标示符指定的cell
    
    UINib *nib = [UINib nibWithNibName:@"VideoListCollectionViewCell" bundle:[NSBundle mainBundle]];
      [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    VideoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoviePlayerViewController *vc = [[MoviePlayerViewController alloc]init];
    
    ArticleModel *model=self.dataSoure[indexPath.item];
    vc.videoURL=[NSURL URLWithString:model.fj_drss];//[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.fj_drss]];
    vc.model=model;
    vc.titleName=self.titleName;
    [self.navigationController pushViewController:vc animated:YES];

}


//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView
                            dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                            withReuseIdentifier:headerViewIdentifier
                            forIndexPath:indexPath];
    
    self.headView = [[LXHeadView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];

    self.headView.HeadViewBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
    };
    NSMutableArray *imagesUrlString=[NSMutableArray array];
    [self.bannerDataSoure enumerateObjectsUsingBlock:^(BannerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imagesUrlString addObject:[NSString stringWithFormat:@"%@%@",Host1,obj.pic]];
    }];
    self.headView.dataArray = imagesUrlString;
    
    [headView addSubview:self.headView];
    
    return headView;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width,150);
    }
    else {
        return CGSizeMake(0, 0);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end

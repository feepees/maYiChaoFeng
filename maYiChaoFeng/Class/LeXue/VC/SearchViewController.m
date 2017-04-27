//
//  SearchViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/6.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "SearchViewController.h"
#import "VideoListCollectionViewCell.h"
#import "MoviePlayerViewController.h"
#import "UIView+FPErrorPage.h"
@interface SearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation SearchViewController


-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.minimumLineSpacing = 10;
        flow.minimumInteritemSpacing =10;
        CGFloat width = (screenWidth-30)/2 - 0.1;
        flow.itemSize = CGSizeMake(width,200);
        _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
        _collection.backgroundColor=[UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"VideoListCollectionViewCell" bundle:[NSBundle mainBundle]];
        [_collection registerNib:nib forCellWithReuseIdentifier:@"VideoListCollectionViewCell"];
        _collection.delegate=self;
        _collection.dataSource=self;
    }
    return _collection;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
    }
    return _dataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    searchBar.delegate=self;
    self.navigationItem.titleView=searchBar;
    [self.view addSubview:self.collection];
    [self.collection showBlankPageView];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"title"]=searchBar.text;
    parameter[@"page"]=@"0";
    parameter[@"page_size"]=@"10";
    MYLog(@"搜索文章API：%@参数：%@",SearchArticle,parameter);
[MJHttpTool Post:SearchArticle parameters:parameter success:^(id responseObject) {
    MYLog(@"搜索返回结果：%@",responseObject);
    self.dataSoure=[ArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    [self.collection reloadData];
    if (!(self.dataSoure.count==0)) {
        [self.collection hideBlankPageView];
    }
} failure:^(NSError *error) {
    MYLog(@"搜索错误%@",error);
}];
}
#pragma mark --------------UICollectionVIewDelegate---------------

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier=@"VideoListCollectionViewCell";
    VideoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.item];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoure.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoviePlayerViewController *vc = [[MoviePlayerViewController alloc]init];
    
    ArticleModel *model=self.dataSoure[indexPath.item];
    vc.videoURL=[NSURL URLWithString:model.fj_drss];//[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.fj_drss]];
    vc.model=model;
    vc.titleName=@"蚁城";
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end

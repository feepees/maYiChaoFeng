//
//  MoviePlayerViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  视频播放界面

#import "MoviePlayerViewController.h"
#import "ZFPlayer.h"
#import "CommentHeadView.h"
#import "CommentTableViewCell.h"
#import "UserModel.h"
#import <UShareUI/UShareUI.h>
#import <MJRefresh.h>
#import "PurchaseViewController.h"

@interface MoviePlayerViewController () <ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource>
/** 播放器View的父视图*/
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property (weak, nonatomic) IBOutlet UIView *playerFatherView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong )UIImageView *cover;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *bottomView;

@property(nonatomic,assign)NSInteger page;
@end

@implementation MoviePlayerViewController
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([self.titleName isEqualToString:@"免费视频"]){
        self.cover.hidden=YES;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBar.hidden=YES;
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCover];
    self.page=0;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.playerView = [[ZFPlayerView alloc] init];
    
    /*****************************************************************************************
     *   // 指定控制层(可自定义)
     *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
     *   // 设置控制层和播放模型
     *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
     ******************************************************************************************/
    [self.playerView playerControlView:nil playerModel:self.playerModel];
    
    // 设置代理
    self.playerView.delegate = self;
    
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    // self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    // 打开下载功能（默认没有这个功能）
    //self.playerView.hasDownload    = YES;
    // 打开预览图
    self.playerView.hasPreviewView = YES;
    
    // 是否自动播放，默认不自动播放
    //[self.playerView autoPlayTheVideo];
    
    //
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=0;
        [self getDataWithPage:0] ;
    }];
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getDataWithPage:self.page];
    }];
    
  __weak  CommentHeadView *headVIew=[[NSBundle mainBundle]loadNibNamed:@"CommentHeadView" owner:nil options:nil].lastObject;
    headVIew.model=self.model;
    headVIew.unfold=^(CGFloat height){
        headVIew.frame=CGRectMake(0, 0, screenWidth, 170+height);
        [self.tableView reloadData];
    };
    headVIew.sendAction=^(NSString *content){
        [self sendCommentWithcontent:content];
    };
    headVIew.shareAction=^{
        [self shareAction];
    };
    headVIew.frame=CGRectMake(0, 0, screenWidth, 170);
    self.tableView.tableHeaderView=headVIew;
    //请求、数据
    [self getDataWithPage:0];
}
//添加购买会员提醒
-(void)setUpCover{
    _cover=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 208)];
    _cover.image=[UIImage imageNamed:@"sp_bj"];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((screenWidth-140)/2, 120, 140, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"sp_aniu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(purchaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((screenWidth-200)/2, 80, 200, 30)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=@"成为经销商可观看";
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 36, 36)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"lxjj_fhjt_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(zf_playerBackAction) forControlEvents:UIControlEventTouchUpInside];
    _cover.userInteractionEnabled=YES;
    [_cover addSubview:backBtn];
    [_cover addSubview:lable];
    [_cover addSubview:button];
    [self.view addSubview:_cover];


}
//发送评论
-(void)sendCommentWithcontent:(NSString *)content{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"a_id"]=self.model.a_id;
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"content"]=content;
    MYLog(@"发送评论API：%@参数%@",AddComment,parameter);
[MJHttpTool Post:AddComment parameters:parameter success:^(id responseObject) {
    MYLog(@"发送评论返回：%@",responseObject);
    if ([responseObject[@"code"] isEqualToString:@"0000"])
    {
        [YJProgressHUD showSuccess:@"评论成功" inview:self.view];
        [self getDataWithPage:0];
    }
    else
    {
        [YJProgressHUD showMessage:@"评论失败" inView:self.view];
    }
} failure:^(NSError *error) {
     [YJProgressHUD showMessage:@"网络异常" inView:self.view];
    MYLog(@"发送评论错误%@",error);
}];
}
//购买会员
-(void)purchaseBtn:(UIButton *)sender{
    PurchaseViewController *purchaseC=[[PurchaseViewController alloc]init];
    [self.navigationController pushViewController:purchaseC animated:YES];
}

//请求、数据
-(void)getDataWithPage:(NSInteger)page{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"a_id"]=self.model.a_id;
    parameter[@"page"]=[NSString stringWithFormat:@"%ld",page];
    parameter[@"page_size"]=@"10";
[MJHttpTool Post:ArticleDetail parameters:parameter success:^(id responseObject) {
    
    MYLog(@"获取文章详情结果：%@",responseObject);
    if (self.page==0) {
        
    
    self.model=[ArticleModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.dataSoure=[CommentModel mj_objectArrayWithKeyValuesArray:self.model.comment];
         [self.tableView.mj_header endRefreshing];
    }
    else{
        self.model=[ArticleModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.dataSoure addObjectsFromArray:[CommentModel mj_objectArrayWithKeyValuesArray:self.model.comment]];
        [self.tableView.mj_footer endRefreshing];
    }
    
    [self.tableView reloadData];
} failure:^(NSError *error) {
    MYLog(@"获取文章详情结果错误%@",error);
}];
}
// 返回值要必须为NO
- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)zf_playerCurrentTime:(NSInteger)CurrentTime{
    
    //NSLog(@"-------------------%ld",CurrentTime);
    
}


#pragma mark - Getter

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"这里设置视频标题";
        _playerModel.videoURL         = self.videoURL;
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.playerFatherView;
        
    }
    return _playerModel;
}

#pragma mark - Action

- (IBAction)playNewVideo:(UIButton *)sender {
    self.playerModel.title            = @"这是新播放的视频";
    self.playerModel.videoURL         = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456665467509qingshu.mp4"];
    // 设置网络封面图
    self.playerModel.placeholderImageURLString = @"http://img.wdjimg.com/image/video/447f973848167ee5e44b67c8d4df9839_0_0.jpeg";
    // 从xx秒开始播放视频
    //     self.playerModel.seekTime         = 15;
    [self.playerView resetToPlayNewVideo:self.playerModel];
}
#pragma mark -----------------友盟分享-----------------------------------------
//分享
-(void)shareAction{
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


#pragma mark -------------------------UITableViewDelegate----------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataSoure[indexPath.item];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
@end

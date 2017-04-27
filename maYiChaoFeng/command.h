//
//  command.h
//  maYiChaoFeng
//
//  Created by Android on 2017/2/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#ifndef command_h
#define command_h

//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UICOLORFROMRGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1];
//获取物理屏幕的尺寸
#define screenHeight   ([UIScreen mainScreen].bounds.size.height)
#define screenWidth    ([UIScreen mainScreen].bounds.size.width)

//控件高度
#define controlHeight 50
#define Pading 15
//颜色配置
#define TABBAR_ITEM_COLOR 0x141414

#define TABBAR_ITEM_COLOR_SELECTED 0xE8390D
//view背景颜色
#define BACKGROUNDCOLOR UICOLORFROMRGB(240,240,240)

//自定义打印
#ifdef DEBUG
#define MYLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MYLog( s, ... )
#endif

#ifdef DEBUG
#define MYPLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define MYPLog( s, ... )
#endif

//字体配置


//-------------------------项目接口------------------------
#define Host1 @"http://test39.xinyv.net"
#define Host @"http://test39.xinyv.net/"

//登陆接口
#define Login Host@"API/user/do_login"

//第三方登陆
#define PlatformLogin Host@"API/user/thirdLogin"

//注册接口
#define Regist Host@"API/user/do_reg"

//修改密码
#define ResetPsaaword Host@"API/user/reset_password"

//修改用户资料
#define UpdataProfile Host@"API/user/update_userinfo"

//我的业绩
#define Performance Host@"API/user/get_rebate_log"

//我的团队
#define Team Host@"API/user/get_team"

//提现
#define Withdrawls Host@"API/user/withdrawals"

//获取用户信息
#define GetProfile Host@"API/user/userinfo"

//用户全部寄送地址
#define GetAllAddress Host@"API/user/getAddressList"

//添加寄送地址
#define AddAddress Host@"API/user/addAddress"

//删除寄送地址
#define DeleteAddress Host@"API/user/delAddress"

//修改寄送地址
#define UpdataAddress Host@"API/user/updateAddress"

//获取默认地址
#define GetDefaultAddreess Host@"API/user/getAddressDefault"

//广告栏接口
#define BannerList Host@"API/ad/getAdList"

//获取文章列表
#define GetArticle Host@"API/article/getArticleList"

//文章详情
#define ArticleDetail Host@"API/article/getArticle"

//文章搜索
#define SearchArticle Host@"API/article/getArticleListByTitle"

//添加评论
#define AddComment Host@"API/article/add_comment"

//修改头像
#define UpdataHead Host@"API/user/update_userhead"

//添加评论
#define AddComment Host@"API/article/add_comment"

//排行榜
#define RankList Host@"API/user/rankingList"

//帮助中心
#define HelpCenter Host@"API/article/help"

//获取文章
#define GetUserArticle Host@"API/user/getArticle"

//商品列表
#define GoodsList Host@"API/goods/getGoodsList"

//商品详情
#define GoodDetail Host@"API/goods/getGoods"

//添加商品
#define AddGoods Host@"API/goods/updateGoods"

//获取购物车信息
#define GetCart Host@"API/cart/getCartList"

//添加购物车
#define AddToCart Host@"API/cart/addCart"

//删除购物车
#define DeleteCart Host@"API/cart/delCart"

//更新购物车
#define UpdataCart Host@"API/cart/updateCart"

//订单列表
#define GetOrderList Host@"API/order/getOrderList"

//添加订单
#define AddOrder Host@"API/order/addOrder"

//删除订单
#define DeleteOrder Host@"API/order/delOrder"

//------------------------本地路径--------------------
//user
#define UserData [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"user.txt"]

#endif /* command_h */

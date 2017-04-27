//
//  HelpDetailViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/23.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "HelpDetailViewController.h"

@interface HelpDetailViewController ()

@end

@implementation HelpDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"帮助中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"url%@",self.url);
    UIWebView *web=[[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url=[NSURL URLWithString:self.url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    // Do any additional setup after loading the view.
}
@end

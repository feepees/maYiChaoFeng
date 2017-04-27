//
//  PersonMessageViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  个人资料

#import "PersonMessageViewController.h"
#import "CommenTableViewCell.h"
#import "UpdataEmailViewController.h"
#import "UpdataGenderViewController.h"
#import "BindingPhoneNumberViewController.h"
#import "HeadViewTableViewCell.h"
#import "VIPGardeViewController.h"
#import "MYAlertVIew.h"
#import "UserModel.h"
#import "MJDatePickerView.h"
#import "UpdataNickNameViewController.h"
#import "ManagerAddressViewController.h"

@interface PersonMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)UIDatePicker *dataPicker;
@end

@implementation PersonMessageViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"个人中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    


}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"CommenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure=[[NSMutableArray alloc]initWithArray:@[@[@"头像",@"昵称",@"邀请码"],@[@"消费商等级"],@[@"手机号码",@"邮箱",@"性别",@"出生日期",@"寄送地址"]]];
    }
    
    return _dataSoure;

}

#pragma ---------UITableVIewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=self.dataSoure[section];

    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"cellId";
    CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(screenWidth-50,5, 40, 40)];
            [cell.contentView addSubview:headView];
            if ([UserModel sharedUserModel].head_pic) {
                NSLog(@"url%@",[NSString stringWithFormat:@"%@%@",Host1,[UserModel sharedUserModel].head_pic ]);
                [headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,[UserModel sharedUserModel].head_pic ]] placeholderImage:[UIImage imageNamed:@"mrtx_f"]];
                
            }
            else{
                headView.image=[UIImage imageNamed:@"mrtx_f"];
            }
        }
        else if(indexPath.item==1){
            if ([UserModel sharedUserModel].nickname) {
                cell.footLable.text=[UserModel sharedUserModel].nickname;

            }else{
             cell.footLable.text=@"昵称";
            }
        }
        else{
            cell.footLable.text=[UserModel sharedUserModel].user_id;
        }
    }
    else if(indexPath.section==1){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        switch (indexPath.item) {
            case 0:{
                if ([UserModel sharedUserModel].mobile) {
                    cell.footLable.text=@"已绑定";

                }else{
                    cell.footLable.text=@"未绑定";
                }
                            }
                break;
            case 1:{
                if([UserModel sharedUserModel].email){
                    cell.footLable.text=@"已绑定";
                }
                else{
                    cell.footLable.text=@"未绑定";

                }
            }
                break;
            case 2:
            {
                if([[UserModel sharedUserModel].sex isEqualToString:@"1"])
                {
                    cell.footLable.text=@"男";
                }
                else if([[UserModel sharedUserModel].sex isEqualToString:@"2"]){
                cell.footLable.text=@"女";
                }
                else{
                    cell.footLable.text=@"保密";

                }
            }
                break;
            case 3:
            {
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                formatter.dateFormat=@"yyyy/MM/dd";
                NSDate *date=[NSDate dateWithTimeIntervalSince1970:[UserModel sharedUserModel].birthday.doubleValue];
                
                cell.footLable.text=[formatter stringFromDate:date];
            }
                break;
                
            default:
                break;
        }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }
    cell.headLable.text=self.dataSoure[indexPath.section][indexPath.item];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            [MYAlertVIew showPhotoAlertToView:self.view withTakePhoto:^{
                UIImagePickerController *pickC=[[UIImagePickerController alloc]init];
                pickC.delegate=self;
                pickC.sourceType=UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:pickC animated:YES completion:nil];
            } andAlbum:^{
                UIImagePickerController *pickC=[[UIImagePickerController alloc]init];
                pickC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                pickC.delegate=self;
                pickC.allowsEditing=YES;
                [self presentViewController:pickC animated:YES completion:nil];
            }];
        }
        else if(indexPath.item==1){
            UpdataNickNameViewController *nickC=[[UpdataNickNameViewController alloc]init];
            [self.navigationController pushViewController:nickC animated:YES];
        }
    }
    else if(indexPath.section==1){
        VIPGardeViewController *vipC=[[VIPGardeViewController alloc]init];
        [self.navigationController pushViewController:vipC animated:YES];
    }
    else{
        switch (indexPath.item) {
            case 0:{
                BindingPhoneNumberViewController *bindingVC=[[BindingPhoneNumberViewController alloc]init];
                [self.navigationController pushViewController:bindingVC animated:YES];
            }
                break;
            case 1:{
                UpdataEmailViewController *bindingVC=[[UpdataEmailViewController alloc]init];
                [self.navigationController pushViewController:bindingVC animated:YES];}
                break;
            case 2:
            {
                UpdataGenderViewController *bindingVC=[[UpdataGenderViewController alloc]init];
                [self.navigationController pushViewController:bindingVC animated:YES];
            }
                break;
            case 3:
                [self showDatePicker];
                break;
            case 4:{
                ManagerAddressViewController *manageerC=[[ManagerAddressViewController alloc]init];
                [self.navigationController pushViewController:manageerC animated:YES];
                
            }
                break;

            default:
                break;
        }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,self.view.frame.size.height - 20)];
    [self.view addSubview:imageView];
    
    // 获取点击的图片
    NSData *data = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.5);
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *base64=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"img"]=str;
    MYLog(@"上传头像API：%@ data%@ ",UpdataHead,base64);
    [MJHttpTool Post:UpdataHead parameters:parameter success:^(id responseObject) {
        MYLog(@"上传头像%@",responseObject);
        [YJProgressHUD showMessage:@"更新成功" inView:self.view];

    } failure:^(NSError *error) {
        MYLog(@"上传头像错误%@",error);
        [YJProgressHUD showMessage:@"更新失败" inView:self.view];

    }];
    [self dismissViewControllerAnimated:picker completion:nil];
}

-(void)showDatePicker{
    
    MJDatePickerView *date = [[NSBundle mainBundle]loadNibNamed:@"MJDatePickerView" owner:nil options:nil].lastObject;
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    date.selectdate = ^(NSDate *date,NSString *dateStr){
        
        MYLog(@"时间字符串：%@时间数据：%@",date,dateStr);
        
        NSTimeInterval time=[date timeIntervalSince1970];
        
        NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
        UserModel *user=[UserModel sharedUserModel];
        parameter[@"user_id"]=user.user_id;
        parameter[@"key"]=@"birthday";
        parameter[@"value"]=[NSString stringWithFormat:@"%f",time];
        MYLog(@"更改时间：API:%@ parameter:%@",UpdataProfile,parameter);
        [MJHttpTool Post:UpdataProfile parameters:parameter success:^(id responseObject) {
            MYLog(@"更改时间响应：%@",responseObject);
            user.birthday=[NSString stringWithFormat:@"%f",time];
            [self.tableView reloadData];
            [UserDataTool getUserProfile];
            [YJProgressHUD showSuccess:@"更新成功" inview:self.view];
        } failure:^(NSError *error) {
            MYLog(@"更改时间错误：%@",error);
            [YJProgressHUD showMessage:@"更新失败" inView:self.view];

        }];

        
    };
    [win addSubview:date];

}

@end

//
//  VisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录页面

#import "VisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitRecordVC.h"
#import "LZPickerView.h"

@interface VisitRecordViewController ()<LZHTableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///拜访对象
@property (nonatomic, strong) TextInputCell *objectCell;
///拜访方式
@property (nonatomic, strong) TextInputCell *wayCell;
///主要事宜
@property (nonatomic, strong) TextInputCell *mainCell;
///拜访结果
@property (nonatomic, strong) TextInputTextView *resultView;
///备注
@property (nonatomic, strong) TextInputTextView *remarkView;
///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;
@property(nonatomic,strong)NSString *typeStr;

@end

@implementation VisitRecordViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenClick) image:IMAGE(@"list")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight -44-64)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //拜访记录
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = YES;
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.placeholder = @"请输入拜访对象";
    
    //拜访记录
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = YES;
    _wayCell.rightArrowImageVIew.hidden = NO;
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"请选择拜访方式";
    _wayCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWayClick)];
    [_wayCell addGestureRecognizer:tap];
    
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
//    self.resultView.userInteractionEnabled = YES;
    _resultView.textView.delegate = self;
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.textView.placeholder = @"请输入拜访结果";

    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_objectCell,_wayCell,_mainCell,_resultView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];

}

- (void)setSectionTwo
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _remarkView = [[TextInputTextView alloc]init];
    _remarkView.frame = CGRectMake(0, 0, APPWidth, 80);
    _remarkView.textView.delegate = self;
    
    _remarkView.titleLabel.text = @"备注";
    _remarkView.textView.placeholder = @"请输入告知仓库事项";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_remarkView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupUI
{
    _typeAry = [NSArray arrayWithObjects:@"当面拜访",@"电话拜访",@"聊天软件拜访",@"其他方式拜访",nil];
    
    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self.view addSubview:self.mainTabelView];
    
    [self setSectionOne];
    [self setSectionTwo];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    self.commitBtn = [UIButton new];
    self.commitBtn.frame = CGRectMake(0, APPHeight -44, APPWidth, 44);
    self.commitBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.commitBtn];
}


#pragma mark ------ 点击事件 --------
//提交点击按钮
- (void)commitBtnOnClickAction
{
    if ([BXSTools stringIsNullOrEmpty:self.objectCell.contentTF.text]) {
        BXS_Alert(@"请输入拜访对象名称");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.mainCell.contentTF.text]) {
        BXS_Alert(@"请输入主要事宜");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.resultView.textView.text]) {
        BXS_Alert(@"请输入拜访结果");
        return;
    }
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"img":@"",
                             @"matters":self.mainCell.contentTF.text,
                             @"name":self.objectCell.contentTF.text,
                             @"remark":self.remarkView.textView.text,
                             @"result":self.resultView.textView.text,
                             @"type":_typeStr
                             };
    [BXSHttp requestGETWithAppURL:@"record/add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

/// MARK: ---- 上传头像
-(void)submitUserPhoto:(UIImage *)pictureimage;
{
    
    NSData *pictureData = UIImageJPEGRepresentation(pictureimage, 0.5);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    NSDictionary *param = @{
                            @"userid"  :[JLCUserData sharedManager].userId,
                            };
    
    NSMutableDictionary * picParam = [JLCRequest getTimeMd5DictWithMenthString:@"user/upfileusericon"];
    
    [picParam addEntriesFromDictionary:param];
    //    NSString * time = [JLCTools stringFromDate];
    //    NSArray *strArray = [@"setting/appUploadImage" componentsSeparatedByString:@"/"];
    //    NSString * mod = strArray[0];
    //    NSString * act = strArray[1];
    //
    //    NSString * sign = [JLCTools makeMD5:[NSString stringWithFormat:@"%@%@%@%@",mod,act,time,Sign_Key]];
    //    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:param];
    //    [dict addEntriesFromDictionary:@{@"mod":mod,
    //                                     @"act":act,
    //                                     @"t":time,
    //                                     @"sign":sign,
    //                                     @"C_ver":CurentVersion,
    //                                     @"C_type":C_type,
    //                                     }];
    
    
    NSMutableString * uploadURL = [NSMutableString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@%@?",[JLCRequest getServerWithNewApp],@"user/upfileusericon"]];
    
    [picParam enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [uploadURL appendFormat:@"&%@=%@",key,obj];
    }];
    
    
    //     NSString * newsurlStr = [HttpManager GetURL:@"setting/appUploadImage" parameter:param OldSign:@"set.html"];
    //    [UserView setOnView:self.view withTitle:@"Loading"];
    [LLHudTools showLoadingMessage:LLLoadingMessage];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
    LLWeakSelf(self);
    [manager POST:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:pictureData name:@"imageFile" fileName:fileName mimeType:@"image/jpeg"];
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [LLHudTools dismiss];
        NSLog(@"上传反馈 %@",responseObject);
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:responseObject];
        
        if (baseModel.code != 0) {
            HYC__ShowAlert(baseModel.message);
            return ;
        }
        [JLCUserData setHYCModelDict:@{@"IconURL":baseModel.result}];
        HYC__ShowAlert(@"上传成功");
        
        weakself.iconImageView.image = pictureimage;
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:LLLoginStateNotification object:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LLHudTools dismiss];
        HYC__ShowAlert(@"上传失败");
        
    }];
}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapWayClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_typeAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//        weakSelf.principalCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
//        weakSelf.priceipalId = weakSelf.principalIdAry[row];
        self.wayCell.contentTF.text = compoentString;
        _typeStr = [NSString stringWithFormat:@"%zd",row];
    };
    
    [self.view addSubview:pickerView];
}

//跳转到拜访记录列表
- (void)screenClick{
    LZVisitRecordVC *vc = [[LZVisitRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

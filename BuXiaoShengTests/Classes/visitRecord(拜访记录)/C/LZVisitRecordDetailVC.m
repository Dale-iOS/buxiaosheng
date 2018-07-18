//
//  LZVisitRecordDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录详情页面

#import "LZVisitRecordDetailVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GKPhotoBrowser.h"


@interface LZVisitRecordDetailVC ()<LZHTableViewDelegate,UITextViewDelegate>
@property(nonatomic,weak)LZHTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)LZVisitModel *model;
///日期
@property(nonatomic,strong)UILabel *dateLbl;
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
@property (nonatomic, strong) UIImageView *visitIMV;
@property(nonatomic,strong)NSMutableArray *photosArrayUrl;
@end

@implementation LZVisitRecordDetailVC
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}

- (LZHTableView *)myTableView
{
    if (myTableView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = LZHBackgroundColor;
        tableView.delegate = self;
        [self.view addSubview:(myTableView = tableView)];
        
    }
    return myTableView;
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录详情"];
    
    _photosArrayUrl = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.myTableView];
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    self.myTableView.dataSoure = self.dataSource;
}

- (void)setSectionOne{
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headview.backgroundColor = LZHBackgroundColor;
    
    //    _dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APPWidth -15*2, 34)];
    //    _dateLbl.backgroundColor = [UIColor whiteColor];
    //    _dateLbl.textColor = CD_Text99;
    //    _dateLbl.font = FONT(12);
    //
    //    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    //    lineView.backgroundColor = LZHBackgroundColor;
    
    //拜访记录
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = NO;
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.placeholder = @"请输入拜访对象";
    _objectCell.contentTF.enabled = NO;
    
    //拜访记录
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = NO;
    _wayCell.rightArrowImageVIew.hidden = NO;
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"请选择拜访方式";
    _wayCell.contentTF.enabled = NO;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWayClick)];
    //    [_wayCell addGestureRecognizer:tap];
    //
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = NO;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.enabled = NO;
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
    _resultView.textView.delegate = self;
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.userInteractionEnabled = NO;
    _resultView.textView.placeholder = @"请输入拜访结果";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_objectCell,_wayCell,_mainCell,_resultView];
    item.canSelected = NO;
    item.sectionView = headview;
    [self.dataSource addObject:item];
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
    _remarkView.userInteractionEnabled = NO;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_remarkView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.dataSource addObject:item];
}

- (void)setSectionThree{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, APPWidth -15*2, 28)];
    textLbl.textColor = CD_Text33;
    textLbl.font = FONT(14);
    textLbl.text = @"图片";
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 104)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    self.visitIMV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 80, 80)];
    self.visitIMV.userInteractionEnabled = YES;
    UITapGestureRecognizer *visitIMVTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(visitIMVTapOnClick)];
    [self.visitIMV addGestureRecognizer:visitIMVTap];
    [bottomView addSubview:self.visitIMV];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[textLbl,bottomView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.dataSource addObject:item];
}

#pragma mark ---- 网络请求 ----
//接口名称 拜访记录详情
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"record/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        //赋值
        _model = [LZVisitModel LLMJParse:baseModel.data];
        self.objectCell.contentTF.text = _model.name;
        self.wayCell.contentTF.text = _model.type;
        self.mainCell.contentTF.text = _model.matters;
        self.resultView.textView.text = _model.result;
        self.remarkView.textView.text = _model.remark;
        [self.visitIMV sd_setImageWithURL:[NSURL URLWithString:_model.img]];
        [_photosArrayUrl addObject:_model.img];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//展示图片
- (void)visitIMVTapOnClick{

    NSMutableArray *photos = [NSMutableArray new];
    [_photosArrayUrl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
//    browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
    [browser showFromVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

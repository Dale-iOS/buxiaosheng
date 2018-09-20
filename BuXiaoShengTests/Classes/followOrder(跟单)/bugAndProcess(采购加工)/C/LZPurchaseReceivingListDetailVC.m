//
//  LZPurchaseReceivingListDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购收货详情页面

#import "LZPurchaseReceivingListDetailVC.h"
#import "LZPurchaseReceivingListDetailModel.h"
#import "LZPurchaseReceivingListDetailProductModel.h"
#import "ReCustomerCell.h"
#import "ReColorsCell.h"
#import "ReTotalCell.h"
#import "LLPhotoBrowser.h"

@interface LZPurchaseReceivingListDetailVC ()<UITableViewDelegate,UITableViewDataSource,SDPhotoBrowserDelegate>
@property (nonatomic, strong)LZPurchaseReceivingListDetailModel *dataModel;
@property (nonatomic, strong)LZPurchaseReceivingListDetailProductModel *productModel;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *imsArray;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation LZPurchaseReceivingListDetailVC

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _myTableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购收货详情"];
    [self.view addSubview:self.myTableView];
    _dataArray = [NSMutableArray array];
    _imsArray = [NSMutableArray array];
    self.myTableView.estimatedRowHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_footerView addSubview:bgView];
    _footerView.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
}

#pragma mark ---- 网络请求 ----
- (void)getData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/yes_handle_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _dataModel = [LZPurchaseReceivingListDetailModel LLMJParse:baseModel.data];
        if (_dataModel.imgs && _dataModel.imgs.length > 0) {
            _imsArray = (NSMutableArray *)[_dataModel.imgs componentsSeparatedByString:@","];
            [self setImageView];
            self.myTableView.tableFooterView = _footerView;
        }
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)getProductData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/yes_handle_product.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _dataArray = [LZPurchaseReceivingListDetailProductModel LLMJParse:baseModel.data];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ReCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReCustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReCustomerCell" owner:self options:nil] lastObject];
            
        }
        cell.dataModel = self.dataModel;
        return cell;
    }else if (indexPath.row == _dataArray.count + 1) {
        ReTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReTotalCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReTotalCell" owner:self options:nil] lastObject];
            
        }
        cell.dataArray = _dataArray;
        return cell;
    }
    else
    {
        ReColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReColorsCell" owner:self options:nil] lastObject];
            
        }
        if (self.dataArray.count > 0) {
            cell.productModel = self.dataArray[indexPath.row - 1];
        }
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 把图片当做tableFootview处理

- (void)setImageView
{
    
    for (int i = 0; i < _imsArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:[self rectAtIndex:i]];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGes:)];
        imgView.backgroundColor = [UIColor redColor];
        [imgView addGestureRecognizer:tap];
        imgView.tag = i;
        
        NSURL *url = [NSURL URLWithString:_imsArray[i]];
        
        [imgView sd_setImageWithURL:url];
        [_footerView addSubview:imgView];
        [self.imageViews addObject:imgView];
    }
    
}

#pragma mark -- 点击
- (void)handleTapGes:(UITapGestureRecognizer *)tap{
    
    NSInteger selectIndex = [(UIImageView *)tap.view tag];
    
    NSLog(@"点击了%ld",selectIndex);
    
    LLPhotoBrowser *browser = [[LLPhotoBrowser alloc] init];
    
    //设置容器视图,父视图
    browser.sourceImagesContainerView = self.view;
    browser.currentImageIndex = selectIndex;
    browser.imageCount = _imsArray.count;
    //设置代理
    browser.delegate = self;
    //显示图片浏览器
    [browser show];
    
}

- (NSURL *)photoBrowser:(LLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [NSURL URLWithString:_imsArray[index]];
    return url;
}


-(CGRect)rectAtIndex:(NSInteger)index{
    //    KcolNumber 每行的个数
    //    Kwidth     控件的宽
    NSInteger KcolNumber = 5;
    CGFloat margin = 10;
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (margin * KcolNumber +1))/(KcolNumber);
    
    CGFloat height = width;
    
    NSUInteger rowIndex = 0;
    NSUInteger colIndex = 0;
    rowIndex = index / KcolNumber;
    colIndex = index % KcolNumber;
    X = colIndex * width + (colIndex)*margin + 5;
    Y = rowIndex * width + (rowIndex)*margin +20;
    return CGRectMake(X, Y, width, height);
}

- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

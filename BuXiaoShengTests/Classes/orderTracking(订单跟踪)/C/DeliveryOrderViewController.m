//
//  DeliveryOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  已交货(销售)

#import "DeliveryOrderViewController.h"
#import "OrderTableViewCell.h"
#import "LZOrderTrackingModel.h"
#import "LZShipmentVC.h"

@interface DeliveryOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate>
{
    UIView *_headerView;
    UILabel *_timeLabel;
    UITableView *_tableView;
    UIView *_rightHeadView;
    NSInteger _page;
}
@property(nonatomic,strong)NSArray<LZOrderTrackingModel *> *lists;

@end

@implementation DeliveryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.frame = CGRectMake(15, 12, APPWidth/2, 14);
    _timeLabel.text = @"所有日期";
    _timeLabel.font = FONT(13);
    _timeLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [_headerView addSubview:_timeLabel];
    
    _rightHeadView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth/2, 0, APPWidth/2, 34)];
    _rightHeadView.backgroundColor = [UIColor clearColor];
    [_headerView addSubview:_rightHeadView];
    
    //筛选图标
    UIImageView *screenImageView = [[UIImageView alloc]init];
    screenImageView.image = IMAGE(@"screen");
    screenImageView.backgroundColor = [UIColor clearColor];
    [_rightHeadView addSubview:screenImageView];
    screenImageView.sd_layout
    .rightSpaceToView(_rightHeadView, 15)
    .centerYEqualToView(_rightHeadView)
    .widthIs(14)
    .heightIs(12);
    
    //筛选文字
    UILabel *screenLabel = [[UILabel alloc]init];
    screenLabel.font = FONT(13);
    screenLabel.text = @"筛选";
    screenLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    [_rightHeadView addSubview:screenLabel];
    screenLabel.sd_layout
    .rightSpaceToView(screenImageView, 4)
    .centerYEqualToView(_rightHeadView)
    .widthIs(28)
    .heightIs(14);
    
    UIButton *screenBtn = [UIButton new];
    screenBtn.backgroundColor = [UIColor clearColor];
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightHeadView addSubview:screenBtn];
    screenBtn.sd_layout
    .leftEqualToView(screenLabel)
    .rightSpaceToView(_rightHeadView, 0)
    .topSpaceToView(_rightHeadView, 0)
    .bottomSpaceToView(_rightHeadView, 0);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    _tableView.tableHeaderView = _headerView;
    
    [self.view addSubview:_tableView];
    
}

- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_delivered_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZOrderTrackingModel LLMJParse:baseModel.data];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"OrderTableViewCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        cell.isFromShipment = YES;
        [cell.shipmentBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

//完成按钮事件
- (void)didClickShipmentBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [_tableView indexPathForCell:cell];
    LZOrderTrackingModel *model = _lists[indexP.row];
    
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认点击完成？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消执行");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        确定的执行事件
//        接口名称 完成订单（已交货状态下）
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"orderId":model.id
                                 };
        [BXSHttp requestGETWithAppURL:@"sale/completed.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"提交成功"];
            [self setupData];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)screenBtnClick
{
    NSLog(@"点击了筛选时间");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

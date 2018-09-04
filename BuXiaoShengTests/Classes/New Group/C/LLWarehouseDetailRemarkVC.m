//
//  LLWarehouseDetailRemarkVC.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseDetailRemarkVC.h"
#import "LLWarehouseSideModel.h"
#import "LLWarehouseDetailCell.h"
@interface LLWarehouseDetailRemarkVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)LLWarehouseDetailModel * dictModel;
@property(nonatomic ,strong)UILabel * timeLable;
@property(nonatomic ,weak)UIView * timeView;
//分匹
@property(nonatomic ,strong)UITextField * fenpiTextField;
@property(nonatomic ,strong)UILabel * fenpiResultLable;
@end

@implementation LLWarehouseDetailRemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    UIView * timeView = [UIView new];
    self.timeView = timeView;
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20+LLNavViewHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    [timeView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.left.equalTo(self.view).offset(12);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.timeView.mas_bottom);
    }];
}

-(void)setupTableFooterView {
    switch (self.fromType) {
        case LLWarehouseDetailRemarkFromTypeFenPi: //分匹
        {
            UIView * fenPiFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
            self.tableView.tableFooterView = fenPiFooterView;
            fenPiFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            UIView * fenPiContenView = [UIView new];
            [fenPiFooterView addSubview:fenPiContenView];
            [fenPiContenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(fenPiFooterView);
                make.top.equalTo(fenPiFooterView).offset(20);
            }];
            fenPiContenView.backgroundColor = [UIColor whiteColor];
            UILabel * fenpiLable = [UILabel new];
            fenpiLable.text = @"分 匹";
            fenpiLable.font = [UIFont systemFontOfSize:16];
            fenpiLable.textColor = [UIColor darkGrayColor];
            [fenPiContenView addSubview:fenpiLable];
            [fenpiLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(fenPiContenView).offset(12);
                make.top.equalTo(fenPiContenView).offset(12);
            }];
            
       }
          
            break;
        case LLWarehouseDetailRemarkFromTypeHePi://合匹
            
            break;
        case LLWarehouseDetailRemarkFromTypeJKJK://加空减空
            
            break;
        case LLWarehouseDetailRemarkFromTypePoSun://破损
            
            break;
        default:
            break;
    }
}

-(void)setupData {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"stockId"] = self.model.stockId;
    param[@"companyId"] = [BXSUser currentUser].companyId;
    [BXSHttp requestGETWithAppURL:@"house_stock/house_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.dictModel = [LLWarehouseDetailModel LLMJParse:baseModel.data];
        self.timeLable.text = [BXSTools stringFrom14Data:self.dictModel.createTime] ;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLWarehouseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWarehouseDetailCell"];
    cell.indexPath = indexPath;
    cell.model = self.dictModel;
    return cell;
}

/// MARK: ---- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LLWarehouseDetailCell class] forCellReuseIdentifier:@"LLWarehouseDetailCell"];
        _tableView.rowHeight = 45;
    }
    return _tableView;
}
-(UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.font = [UIFont systemFontOfSize:15];
        _timeLable.textColor = [UIColor darkGrayColor];
    }
    return _timeLable;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

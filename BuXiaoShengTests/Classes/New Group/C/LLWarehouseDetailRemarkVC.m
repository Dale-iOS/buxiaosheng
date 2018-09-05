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
#import "LLWarehouseDetaiSlideRemakeVc.h"
@interface LLWarehouseDetailRemarkVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic ,strong)UITableView * tableView;
//分匹
@property(nonatomic ,strong)UITextField * fenpiTextField;
@property(nonatomic ,strong)UILabel * fenpiResultLable;

//和匹
@property(nonatomic ,strong)UITextField * hepiTextField;

@property(nonatomic ,strong)NSMutableArray <LLWarehouseDetailModel*>* dataSource;

@end

@implementation LLWarehouseDetailRemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataSource addObject:self.dictModel];
    [self setupUI];
    [self setupTableFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    UIButton * makeSureButton = [UIButton new];
    [self.view addSubview:makeSureButton];
    makeSureButton.backgroundColor = LZAppBlueColor;
    [makeSureButton addTarget:self action:@selector(makeSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    makeSureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [makeSureButton setTitle:@"确 定" forState:UIControlStateNormal];
    [makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(45);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.bottom.equalTo(makeSureButton.mas_top);
    }];
   
}

-(void)setupTableFooterView {
    UIView * tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableView.tableFooterView = tableFooterView;
    tableFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * tableFooterContenView = [UIView new];
    [tableFooterView addSubview:tableFooterContenView];
    [tableFooterContenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(tableFooterView);
        make.top.equalTo(tableFooterView).offset(20);
    }];
    tableFooterContenView.backgroundColor = [UIColor whiteColor];
    UILabel * titleLable = [UILabel new];
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.textColor = [UIColor darkGrayColor];
    [tableFooterContenView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableFooterContenView).offset(12);
        make.top.equalTo(tableFooterContenView).offset(12);
    }];
    switch (self.fromType) {
        case LLWarehouseDetailRemarkFromTypeFenPi: //分匹
        {
            titleLable.text = @"分 匹:";
            UIImageView * centerIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conversion"]];
            [tableFooterContenView addSubview:centerIv];
            [centerIv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(tableFooterContenView);
                make.centerY.equalTo(tableFooterContenView).offset(10);
            }];
            self.fenpiTextField = [UITextField new];
            self.fenpiTextField.textAlignment = NSTextAlignmentRight;
            self.fenpiTextField.delegate = self;
            self.fenpiTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.fenpiTextField.returnKeyType = UIReturnKeyNext;
            self.fenpiTextField.placeholder = @"请输入你要计算的值";
            [tableFooterContenView addSubview:self.fenpiTextField];
            self.fenpiTextField.font = [UIFont systemFontOfSize:14];
            self.fenpiTextField.textColor = [UIColor darkGrayColor];
            [self.fenpiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(12);
                make.centerY.equalTo(centerIv);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(35);
            }];
            self.fenpiResultLable = [UILabel new];
            [tableFooterContenView addSubview:self.fenpiResultLable];
            self.fenpiResultLable.font = [UIFont systemFontOfSize:16];
            self.fenpiResultLable.textColor = [UIColor darkGrayColor];
            [self.fenpiResultLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo (centerIv.mas_right).offset(20);
                make.centerY.equalTo(centerIv);
            }];
            
       }
          
            break;
        case LLWarehouseDetailRemarkFromTypeHePi://合匹
        {
            titleLable.text = @"合匹:";
            UILabel * hepiLeftLable = [UILabel new];
            hepiLeftLable.text = @"合匹";
            hepiLeftLable.font = [UIFont systemFontOfSize:16];
            hepiLeftLable.textColor = [UIColor blackColor];
            [tableFooterContenView addSubview:hepiLeftLable];
            [hepiLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(12);
                make.centerY.equalTo(tableFooterContenView).offset(12);
            }];
            self.hepiTextField = [UITextField new];
            self.hepiTextField.textAlignment = NSTextAlignmentCenter;
            self.hepiTextField.delegate = self;
            self.hepiTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.hepiTextField.returnKeyType = UIReturnKeyNext;
            self.hepiTextField.userInteractionEnabled = false;
            self.hepiTextField.placeholder = @"请选择添加的合匹";
            [tableFooterContenView addSubview:self.hepiTextField];
            self.hepiTextField.font = [UIFont systemFontOfSize:14];
            self.hepiTextField.textColor = [UIColor darkGrayColor];
            [self.hepiTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(37);
                make.centerY.equalTo(hepiLeftLable);
                make.right.mas_equalTo(tableFooterContenView).offset(-37);
                make.height.mas_equalTo(35);
            }];
            
            UIImageView * arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightarrow"]];
            [tableFooterContenView addSubview:arrowIv];
            [arrowIv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(tableFooterContenView).offset(-12);
                make.centerY.equalTo(hepiLeftLable);
            }];
            addGestureRecognizer(tableFooterContenView, tableFooterContenViewClick)
        }
            break;
        case LLWarehouseDetailRemarkFromTypeJKJK://加空减空
            
            break;
        case LLWarehouseDetailRemarkFromTypePoSun://破损
            
            break;
        default:
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLWarehouseDetailHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLWarehouseDetailHeaderFooterView"];
    headerView.timeLable.text = [BXSTools stringFrom14Data:self.dataSource[section].createTime] ;
    return headerView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLWarehouseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLWarehouseDetailCell"];
    cell.indexPath = indexPath;
    cell.model = self.dataSource[indexPath.section];
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:true];
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([BXSTools stringIsNullOrEmpty:textField.text]) {
        [LLHudTools showWithMessage:@"请输入内容"];
        return;
    }
     self.fenpiResultLable.text = [@([self.dictModel.number integerValue] - [textField.text integerValue]) stringValue];
    
}
/// MARK: ---- 需要侧滑的
-(void)tableFooterContenViewClick{
    if (self.fromType == LLWarehouseDetailRemarkFromTypeHePi) { //合匹
        LLWarehouseDetaiSlideRemakeVc * rightSildeVc = [LLWarehouseDetaiSlideRemakeVc new];
        rightSildeVc.dictModel = self.dictModel;
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self cw_showDrawerViewController:rightSildeVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    }
}
/// MARK: ---- 确定按钮
-(void)makeSureButtonClick {
    
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    if (self.fromType == LLWarehouseDetailRemarkFromTypeFenPi) {//分匹
        param[@"companyId"] = [BXSUser currentUser].companyId;
        param[@"number"] = self.fenpiTextField.text;
        param[@"stockId"] = self.model.stockId;
        [BXSHttp requestGETWithAppURL:@"house_stock/split_match.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue]!=200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
             [LLHudTools showWithMessage:baseModel.msg];
            [self.navigationController popViewControllerAnimated:true];
        } failure:^(NSError *error) {
            [LLHudTools showWithMessage:LLLoadErrorMessage];
        }];
        
    }
}

/// MARK: ---- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LLWarehouseDetailCell class] forCellReuseIdentifier:@"LLWarehouseDetailCell"];
        [_tableView registerClass:[LLWarehouseDetailHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"LLWarehouseDetailHeaderFooterView"];
        _tableView.rowHeight = 45;
    }
    return _tableView;
}

-(NSMutableArray<LLWarehouseDetailModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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

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
@interface LLWarehouseDetailRemarkVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,LLWarehouseDetaiSlideRemakeVcDelegate>
@property(nonatomic ,strong)UITableView * tableView;
//分匹
@property(nonatomic ,strong)UITextField * fenpiTextField;
@property(nonatomic ,strong)UILabel * fenpiResultLable;

//和匹
@property(nonatomic ,strong)UITextField * hepiTextField;

//加空减空
@property(nonatomic ,strong)UITextField *JKJKTextField;
//加空减空选择按钮
@property(nonatomic ,strong)UIView * JKJKButtonContentView;
//加空减空type参数
@property(nonatomic ,copy)NSString * jkjkType;

//破损
@property(nonatomic ,strong)UITextField *posunTextField;
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
        {
            titleLable.text = @"加空减空:";
            UIImageView * askMarkIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt"]];
            [tableFooterContenView addSubview:askMarkIv];
            [askMarkIv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLable.mas_right).offset(12);
                make.centerY.equalTo(titleLable);
            }];
            UILabel * JKJKLeftLable = [UILabel new];
            JKJKLeftLable.text = @"加空减空";
            JKJKLeftLable.font = [UIFont systemFontOfSize:16];
            JKJKLeftLable.textColor = [UIColor blackColor];
            [tableFooterContenView addSubview:JKJKLeftLable];
            [JKJKLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(12);
                make.centerY.equalTo(tableFooterContenView).offset(12);
            }];
            
            self.JKJKTextField = [UITextField new];
            self.JKJKTextField.textAlignment = NSTextAlignmentCenter;
            self.JKJKTextField.delegate = self;
            self.JKJKTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.JKJKTextField.returnKeyType = UIReturnKeyNext;
            self.JKJKTextField.placeholder = @"请输入减价数值";
            [tableFooterContenView addSubview:self.JKJKTextField];
            self.JKJKTextField.font = [UIFont systemFontOfSize:14];
            self.JKJKTextField.textColor = [UIColor darkGrayColor];
            [self.JKJKTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(50);
                make.centerY.equalTo(JKJKLeftLable);
                make.right.mas_equalTo(tableFooterContenView).offset(-150);
                make.height.mas_equalTo(35);
            }];
            
            self.JKJKButtonContentView = [UIView new];
            [tableFooterContenView addSubview:self.JKJKButtonContentView];
            [self.JKJKButtonContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.JKJKTextField.mas_right);
                make.top.bottom.right.equalTo(tableFooterContenView);
            }];
            [self.JKJKButtonContentView layoutIfNeeded];
            CGFloat width = 150/2;
            for (int i = 0; i<2; i++) {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.JKJKButtonContentView addSubview:btn];
                btn.tag = i;
                if (i == 0) {
                    [btn setTitle:@"加空" forState:UIControlStateNormal];
                    btn.selected = true;
                }else {
                     [btn setTitle:@"减空" forState:UIControlStateNormal];
                }
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn addTarget:self action:@selector(jkjkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"noSelect1"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"yesSelect1"] forState:UIControlStateSelected];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.JKJKButtonContentView).offset(i*width);
                    make.centerY.equalTo(JKJKLeftLable);
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(35);
                }];
            }
        }
            break;
        case LLWarehouseDetailRemarkFromTypePoSun://破损
        {
            titleLable.text = @"破损:";
            UILabel * posunLeftLable = [UILabel new];
            posunLeftLable.text = @"破损";
            posunLeftLable.font = [UIFont systemFontOfSize:16];
            posunLeftLable.textColor = [UIColor blackColor];
            [tableFooterContenView addSubview:posunLeftLable];
            [posunLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(12);
                make.centerY.equalTo(tableFooterContenView).offset(12);
            }];
            
            self.posunTextField = [UITextField new];
            self.posunTextField.textAlignment = NSTextAlignmentCenter;
            self.posunTextField.delegate = self;
            self.posunTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.posunTextField.returnKeyType = UIReturnKeyNext;
            self.posunTextField.placeholder = @"请输入具体米数";
            [tableFooterContenView addSubview:self.posunTextField];
            self.posunTextField.font = [UIFont systemFontOfSize:14];
            self.posunTextField.textColor = [UIColor darkGrayColor];
            [self.posunTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tableFooterContenView).offset(50);
                make.centerY.equalTo(posunLeftLable);
                make.right.mas_equalTo(tableFooterContenView).offset(-50);
                make.height.mas_equalTo(35);
            }];
        }
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
    if (self.fromType == LLWarehouseDetailRemarkFromTypeFenPi) {
       self.fenpiResultLable.text = [@([self.dictModel.number integerValue] - [textField.text integerValue]) stringValue];
    }
    
    
}
/// MARK: ---- 侧滑选中点击的代理
-(void)warehouseDetaiSlideDelegateWithSeletedModel:(LLWarehouseSideRigthRowModel *)model {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"stockId"] =  model.stockId;
    param[@"companyId"] = [BXSUser currentUser].companyId;
    [BXSHttp requestGETWithAppURL:@"house_stock/house_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
         [LLHudTools showWithMessage:@"合匹成功"];
        LLWarehouseDetailModel * hepiModel = [LLWarehouseDetailModel LLMJParse:baseModel.data];
        [self.dataSource addObject:hepiModel];
        [self.tableView reloadData];
        self.tableView.tableFooterView = nil;
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}
/// MARK: ---- 加空减空按钮选择点击
-(void)jkjkBtnClick:(UIButton*)btn {
    [self.JKJKButtonContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = false;
    }];
    btn.selected = true;
    self.jkjkType = btn.tag ==0 ? @"0":@"1";
}
/// MARK: ---- 需要侧滑的
-(void)tableFooterContenViewClick{
    if (self.fromType == LLWarehouseDetailRemarkFromTypeHePi) { //合匹
        LLWarehouseDetaiSlideRemakeVc * rightSildeVc = [LLWarehouseDetaiSlideRemakeVc new];
       rightSildeVc.delegate = self;
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
        
    }else if(self.fromType == LLWarehouseDetailRemarkFromTypeHePi) {//合匹
        if (self.dataSource.count!=2) {
            [LLHudTools showWithMessage:@"合匹未成功,请重新合匹"];
            return;
        }
        param[@"companyId"] = [BXSUser currentUser].companyId;
        param[@"stockId"] = self.dataSource.firstObject.stockId;
        param[@"matchStockId"] = self.dataSource.lastObject.stockId;
        param[@"number"] = self.dataSource.lastObject.number;
        [BXSHttp requestGETWithAppURL:@"house_stock/match.do" param:param success:^(id response) {
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
    }else if (self.fromType == LLWarehouseDetailRemarkFromTypeJKJK) {//加空减空
        if ([BXSTools stringIsNullOrEmpty:self.JKJKTextField.text]) {
            [LLHudTools showWithMessage:@"请输入你要加减的值"];
            return;
        }
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        param[@"companyId"] = [BXSUser currentUser].companyId;
        param[@"number"] = self.JKJKTextField.text;
        param[@"stockId"] = self.dictModel.stockId;
        param[@"type"] = self.jkjkType ? : @"0";
        [BXSHttp requestGETWithAppURL:@"house_stock/operation_stock.do" param:param success:^(id response) {
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
    }else { //破损
        if ([BXSTools stringIsNullOrEmpty:self.posunTextField.text]) {
            [LLHudTools showWithMessage:@"请输入折损米数"];
            return;
        }
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        param[@"companyId"] = [BXSUser currentUser].companyId;
        param[@"number"] = self.posunTextField.text;
        param[@"stockId"] = self.dictModel.stockId;
        [BXSHttp requestGETWithAppURL:@"house_stock/damage.do" param:param success:^(id response) {
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

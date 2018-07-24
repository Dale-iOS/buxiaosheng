//
//  LZSelectItemViewController.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSelectItemViewController.h"
#import "UIBarButtonItem+CJExtension.h"
#import "salesDemandModel.h"

@interface LZSelectItemViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray<NSMutableDictionary *> *dataSource;
//产品数组
@property (nonatomic, strong) NSMutableArray <productListModel *> *products;
@property (nonatomic, strong) NSMutableArray *productsListMTArray;//产品列表名称数组
@property (nonatomic, strong) NSMutableArray *productsIdMTArray;//产品列表ID数组
//颜色数组
@property (nonatomic, strong) NSMutableArray <productListModel *> *colors;
@property (nonatomic, strong) NSMutableArray *colorsListMTArray;//颜色列表名称数组
@property (nonatomic, strong) NSMutableArray *colorsIdMTArray;//颜色列表ID数组
@end

static NSString *cellId = @"UITableViewCell";

@implementation LZSelectItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self removeExtraCellLine];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    if (LZSelectItemVCSelectProduct == _type) {
        //选择产品
        [self setupProductData];
    } else if (LZSelectItemVCSelectColor == _type) {
        [self setupColorData];
    } else if (LZSelectItemVCSelectWarehouse == _type) {
//        datas = @[@"入仓1", @"入仓2", @"入仓3", @"入仓4", @"入仓5"];
    } else if (LZSelectItemVCSelectPayMentWay == _type) {
//        datas = @[@"方式1", @"方式2", @"方式3", @"方式4", @"方式5"];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - Private Methods
//设置导航条内容
- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" norColor:RGB(0, 99, 251) targer:self action:@selector(handleSureBtnAction)];
}

//移除多余cell的分割线
- (void)removeExtraCellLine {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.opaque = NO;
    [self.tableView setTableFooterView:view];
}

#pragma mark - Events
- (void)handleSureBtnAction {
    //1.检查是否选中其中一项
    __block BOOL isSelect;
    __block NSMutableDictionary *mDic = nil;
    [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"isSelect"] boolValue]) {
            isSelect = YES;
            mDic = obj;
        };
    }];
    if (NO == isSelect) {
        [LLHudTools showWithMessage:@"请选择一项"];
        return;
    }
    if (nil == mDic) {
        [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"isSelect"] boolValue]) {
                mDic = obj;
            };
        }];
    }
    //2.把选中的一项传到上一界面
    if (_selectItemBlock) {
        _selectItemBlock(mDic[@"text"]);
    }
    //3.返回
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSMutableDictionary *dic = self.dataSource[indexPath.row];
    UITableViewCellAccessoryType type = [dic[@"isSelect"] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.accessoryType = type;
    cell.textLabel.text = dic[@"text"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //1.数据全部置为未选中
    [self.dataSource enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj[@"isSelect"] = @(NO);
    }];
    //2.改变选中cell的数据
    NSMutableDictionary *dic = self.dataSource[indexPath.row];
    NSMutableDictionary *tmpDic = [[dic copy] mutableCopy];
    tmpDic[@"isSelect"] = @(YES);
    [dic setDictionary:tmpDic];
    //3.刷新表格
    [tableView reloadData];
    
    [self handleSureBtnAction];
}

#pragma mark ----- 网络请求 ------
//功能用到产品列表
- (void)setupProductData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"searchName":@""
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
//        文档接口网址
//        http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#288
        _products = [productListModel LLMJParse:baseModel.data];
        //拼接要展示的列表数据
        //产品名字
        _productsListMTArray = [NSMutableArray array];
        //产品id
        _productsIdMTArray = [NSMutableArray array];
        if (_products) {
            for (int i = 0; i <_products.count; i++) {
                productListModel *model = [productListModel LLMJParse:_products[i]];
                [_productsListMTArray addObject:model.name];
                [_productsIdMTArray addObject:model.id];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

//功能用到颜色列表
- (void)setupColorData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"searchName":@"",
                             @"productId":@""
                             };
    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        //        文档接口网址
        //        http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#293
        _colors = [productListModel LLMJParse:baseModel.data];
        //拼接要展示的列表数据
        //颜色名字
        _colorsListMTArray = [NSMutableArray array];
        //颜色id
        _colorsIdMTArray = [NSMutableArray array];
        if (_colors) {
            for (int i = 0; i <_products.count; i++) {
                productListModel *model = [productListModel LLMJParse:_products[i]];
                [_colorsListMTArray addObject:model.name];
                [_colorsIdMTArray addObject:model.id];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Getter && Setter
- (NSArray *)dataSource {
    if (_dataSource == nil) {
#warning to do ...此处为假数据,应从接口获取
        NSArray *datas = @[];
        if (LZSelectItemVCSelectProduct == _type) {
//            datas = _productsListMTArray;
            datas = @[@"产品1", @"产品2", @"产品3", @"产品4", @"产品5"];
        } else if (LZSelectItemVCSelectColor == _type) {
            datas = @[@"颜色1", @"颜色2", @"颜色3", @"颜色4", @"颜色5"];
        } else if (LZSelectItemVCSelectWarehouse == _type) {
            datas = @[@"入仓1", @"入仓2", @"入仓3", @"入仓4", @"入仓5"];
        } else if (LZSelectItemVCSelectPayMentWay == _type) {
            datas = @[@"方式1", @"方式2", @"方式3", @"方式4", @"方式5"];
        }
        
        NSMutableArray *tempArr = @[].mutableCopy;
        [datas enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *mDic = @{@"text":obj,
                                  @"isSelect":@(NO)
                                  }.mutableCopy;
            [tempArr addObject:mDic];
        }];
        _dataSource = tempArr;
    }
    return _dataSource;
}


@end

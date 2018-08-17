//
//  BXSMachiningProduuctCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//


/*
 每个产品对应一个table
 table.header -->产品名-->mainTable.cell
 s1.header  --> 产品名的颜色--headCell
 s1.row >0  --> 底bu--DBCell
 s1.footer -->添加底布的按钮
 */
#import "BXSMachiningProduuctCell.h"
///VC
#import "BXSChooseProductVC.h"
#import "LLOutboundSeletedVC.h"
#import "LZSearchVC.h"

///cell
#import "BXSMachiningDBCell.h"
#import "BXSMachiningDBHeaderfooterView.h"

///Model
#import "salesDemandModel.h"

@interface BXSMachiningProduuctCell ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *table;
@end
@implementation BXSMachiningProduuctCell
{
    UILabel *_nameLanel;//产品名
    UILabel *_needLabel;//产品需求
    UIButton *_rightButton;
}

-(void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:UITableViewStyleGrouped];
    [self.contentView addSubview:_table];
    _table.sd_layout.spaceToSuperView(UIEdgeInsetsMake(50, 0, 0, 0));
    _table.contentInset = UIEdgeInsetsZero;
    _table.separatorInset = UIEdgeInsetsZero;
    _table.separatorColor  = LZHBackgroundColor;
    
    _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _table.tableFooterView = [UIView new];
    
    _table.estimatedRowHeight = 0;
    _table.estimatedSectionHeaderHeight = 0;
    _table.estimatedSectionFooterHeight = 0;
    
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor whiteColor];
    _table.scrollEnabled = NO;
    //cell
    
    //[_table registerClass:[BXSMachiningHeadCell class] forCellReuseIdentifier:[BXSMachiningHeadCell cellID]];
    [_table registerClass:[BXSMachiningDBCell class] forCellReuseIdentifier:[BXSMachiningDBCell cellID]];
    _table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
   
    [_table registerClass:[BXSMachiningDBHeaderfooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    [_table registerClass:[BXSMachiningDBHeaderfooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    //header
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 50)];
    [self.contentView addSubview:head];
    
    _nameLanel = [UILabel new];
    _nameLanel.textColor = [UIColor colorWithHexString:@"#333333"];
    _nameLanel.font = [UIFont systemFontOfSize:14];
    _nameLanel.text = @"品名儿二";
    _nameLanel.frame = CGRectMake(15, 0, 80, head.height);
    [head addSubview:_nameLanel];
    
    _needLabel =  [UILabel new];
    _needLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _needLabel.font = [UIFont systemFontOfSize:14];
    _needLabel.text = @"需求量：3";
    _needLabel.frame = CGRectMake(_nameLanel.right+5, 0, 120, head.height);
    [head addSubview:_needLabel];
    
    
    _rightButton = [ComView foldingBtnWithSupView:head];
    [_rightButton addTarget:self action:@selector(clickShow:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.selected = YES;
    
}


-(void)setProductModel:(LZPurchaseModel *)productModel {
    _productModel = productModel;
    [self tableViewHeight];
    [_table reloadData];
    
}
//MARK: --- Click ----
- (void)selectColor:(NSIndexPath *)indexPath {
    
    NSMutableArray *dsArr = _productModel.itemList[indexPath.section].dsArray;
    BXSDSModel *kmodel = dsArr[indexPath.row];
    if (kmodel.productId.length == 0) {
        [LLHudTools showWithMessage:@"请先选择产品"];
        return;
    }
    
    LZSearchVC * rightSeletedVc = [LZSearchVC new];
    WEAKSELF;
    rightSeletedVc.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
        
        kmodel.productColorId = seletedModel.id;
        kmodel.productColorName = seletedModel.name;
        [weakSelf.table reloadData];
    };
    
    rightSeletedVc.productId = kmodel.productId;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.contentVC.navigationController cw_showDrawerViewController:rightSeletedVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
}

- (void)clickShow:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _table.hidden = !sender.selected;
    _productModel.isShow = !_table.hidden;
    [self.contentVC.mainTable reloadData];
    
}

/// 添加底色
- (void)clickAddDB:(NSInteger)section {
    
    BXSDSModel *dsModel = [BXSDSModel new];
    [_productModel.itemList[section].dsArray addObject:dsModel];
    [self tableViewHeight];
    [self.table reloadData];
    [self reloadSuperTable];
 
}

//MARK: ---- UITableViewDataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _productModel.itemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *dsArr = _productModel.itemList[section].dsArray;
    return dsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WEAKSELF
    BXSMachiningDBCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSMachiningDBCell cellID]];
    NSMutableArray *dsArr = _productModel.itemList[indexPath.section].dsArray;
    BXSDSModel *model = dsArr[indexPath.row];
    cell.model = model;
    
    
    cell.clickDelectDBBlock = ^{
        if (dsArr.count > indexPath.row) {
            [dsArr removeObjectAtIndex:indexPath.row];
            
            !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
            [weakSelf tableViewHeight];
            [weakSelf reloadSuperTable];
        }
    };
    cell.clickNameCellBlock = ^(BXSDSModel *dsModel) {
        BXSChooseProductVC *VC = [BXSChooseProductVC new];
        
        [weakSelf.contentVC.navigationController pushViewController:VC animated:YES];
        VC.selectProduct = ^(productListModel *model) {
            
           dsModel.productId = model.id;
            dsModel.productName = model.name;
            [weakSelf.table reloadData];
        };
    };
  
    cell.needGetBottomDataBlock = ^{
        weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
    };
    cell.clickColorCellBlock = ^{
        
        [weakSelf selectColor:indexPath];
    };
    
    //typeof(cell) __weak  weakCell = cell;
    cell.addCKClickBlock = ^(BXSDSModel *dsModel) {
        if ([BXSTools stringIsNullOrEmpty:dsModel.productId]) {
            [LLHudTools showWithMessage:@"请选择商产品"];
            return ;
        }
        if ([BXSTools stringIsNullOrEmpty:dsModel.productColorId]) {
            [LLHudTools showWithMessage:@"请选择颜色"];
            return ;
        }
        LLOutboundSeletedVC *boundSeletedVC = [LLOutboundSeletedVC new];
        LZOutboundItemListModel * itemModel = [LZOutboundItemListModel new];
        itemModel.productId = dsModel.productId;
        itemModel.productColorId = dsModel.productColorId;
        boundSeletedVC.itemModel = itemModel;
       
        boundSeletedVC.block = ^(NSArray<LLOutboundRightModel *> *seleteds, LZOutboundItemListModel *lastModel) {
            
            for (LLOutboundRightModel *aModel in seleteds) {
                   aModel.outgoingCount = aModel.number;
            }
         
            if (seleteds.count > 0) {
                [dsModel.boundModelList addObjectsFromArray:seleteds];
            } 
            
            [weakSelf reloadSuperTable];
            !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
           
        };
        [weakSelf.contentVC presentViewController:boundSeletedVC animated:YES completion:^{ }];
    };
    
    cell.clickDelectAKcBlock = ^{
        
        [weakSelf.table reloadData];
        !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
        [weakSelf reloadSuperTable];
    };
    cell.addLabel.text = [NSString stringWithFormat:@"添加底步%ld",indexPath.row+1];
    return cell;
}

//MARK: ---- UITableViewDelegate ---
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BXSMachiningDBHeaderfooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    LZPurchaseItemListModel *item = _productModel.itemList[section];
    
    header.colorlabel.text = [NSString stringWithFormat:@"颜色：%@",item.productColorName];
    header.needLabel.text = [NSString stringWithFormat:@"需求量：%@",item.number];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *dsArr = _productModel.itemList[indexPath.section].dsArray;
    BXSDSModel *model = dsArr[indexPath.row];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  
        return 60.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    BXSMachiningDBHeaderfooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];

    WEAKSELF;
    [footer.addDBButton addHanderBlock:^(UIView *sender) {
        [weakSelf clickAddDB:section];
    }];
    return footer;
}

//MARK: -- private

/// 计算table的整个高度
- (CGFloat)tableViewHeight {
    CGFloat cellHeight = 50.0f;
    for (LZPurchaseItemListModel *pModel in _productModel.itemList) {
        cellHeight += 110;
        
        for (BXSDSModel *dModel in pModel.dsArray) {
            cellHeight += dModel.cellHeight;
        }
    }
    _productModel.cellHeight = cellHeight;
    return   cellHeight;
}


- (void)reloadSuperTable {
    [self tableViewHeight];
    [_table reloadData];
    WEAKSELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.contentVC.mainTable reloadData];
    });
}
@end

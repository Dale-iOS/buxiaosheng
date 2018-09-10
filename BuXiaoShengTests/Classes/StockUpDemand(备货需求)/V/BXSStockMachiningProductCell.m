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
#import "BXSStockMachiningProductCell.h"
///VC
#import "BXSChooseProductVC.h"
#import "LLOutboundSeletedVC.h"
#import "LZSearchVC.h"


///cell
#import "BXSMachiningDBCell.h"
#import "BXSMachiningDBHeaderfooterView.h"
#import "CellView.h"

///Model
#import "salesDemandModel.h"
#import "UITextField+PopOver.h"
@interface BXSStockMachiningProductCell ()<UITableViewDelegate,UITableViewDataSource,ConItemDelegate,UITextFieldDelegate>

@property (strong,nonatomic)UITableView *table;
@property (nonatomic,strong) NSArray *headDataArr;
@end
@implementation BXSStockMachiningProductCell
{
    UILabel *_nameLanel;//产品名
    UILabel *_needLabel;//产品需求
    UIButton *_rightButton;
//    NSArray *_headDataArr;
}

-(void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:UITableViewStyleGrouped];
    [self.contentView addSubview:_table];
    _table.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
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
    
    [_table registerClass:[ConCell class] forCellReuseIdentifier:[ConCell cellID]];
    [_table registerClass:[BXSMachiningDBCell class] forCellReuseIdentifier:[BXSMachiningDBCell cellID]];
    _table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [_table registerClass:[BXSMachiningDBHeaderfooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    [_table registerClass:[BXSMachiningDBHeaderfooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    //_headDataArr
    ConItem *item0 = [[ConItem alloc]initWithTitle:@"*商品名" kpText:@"请输入商品名" conType:ConTypeB];
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"*颜色" kpText:@"请选择颜色" conType:ConTypeA];
    ConItem *item2 = [[ConItem alloc]initWithTitle:@"*需求量" kpText:@"请输需求量" conType:ConTypeB];
    _headDataArr  =@[item0,item1,item2];
}


-(void)setProductModel:(LZPurchaseModel *)productModel {
    _productModel = productModel;
    [self tableViewHeight];
    [_table reloadData];
    
}
//MARK: --- Click ----
- (void)selectColor:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_productModel.productName == nil) {
            [LLHudTools showWithMessage:@"请先选择产品"];
        }
        return;
    }
    NSMutableArray *dsArr = _productModel.itemList[0].dsArray;
    BXSDSModel *kmodel = dsArr[indexPath.row];
    if (kmodel.productId.length == 0) {
        [LLHudTools showWithMessage:@"请先选择产品"];
        return;
    }
    
   
    LZSearchVC * rightSeletedVc = [LZSearchVC new];
    WEAKSELF;
    rightSeletedVc.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
        if (indexPath.section == 0) {
            weakSelf.productModel.productColorId = seletedModel.id;
            weakSelf.productModel.productColorName = seletedModel.name;
            [weakSelf.table reloadData];
        }else{
            kmodel.productColorId = seletedModel.id;
            kmodel.productColorName = seletedModel.name;
            [weakSelf.table reloadData];
        }
   
    };
    
    rightSeletedVc.productId = indexPath.section == 1?kmodel.productId:_productModel.productId;
    
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
    [_productModel.itemList[0].dsArray addObject:dsModel];
    [self tableViewHeight];
    [self.table reloadData];
    WEAKSELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.contentVC.mainTable reloadData];
    });
    
    
}

- (void)inputEnd:(NSIndexPath *)indexPath {
  
    
}

//MARK: ---- UITableViewDataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _headDataArr.count;
    }else{
        NSMutableArray *dsArr = _productModel.itemList[0].dsArray;
        return dsArr.count;
    }
}
- (void)inputShouldChangeCharactersInRangeWithTextField:(UITextField *)pTextField withCellItem:(ConCell *)pCellItem{
		pTextField.delegate = self;
		pTextField.scrollView = (UIScrollView *)self.contentVC.view;
		pTextField.positionType = ZJPositionTopTwo;
		WEAKSELF;
		[pTextField popOverSource:weakSelf.productsListNameArray index:^(NSInteger index) {
			ConItem *tConTiem = weakSelf.headDataArr [pCellItem.indexPath.row];
			tConTiem.contenText = weakSelf.productsListNameArray[index];
			[weakSelf.table reloadData];
		}];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       WEAKSELF
    if (indexPath.section == 0) {
        ConCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConCell cellID]];
        cell.item = _headDataArr[indexPath.row];
		cell.indexPath = indexPath;
		cell.inputShouldChangeCharactersInRangeBlock = ^(UITextField *textField, ConCell *withCellItem) {
			[weakSelf inputShouldChangeCharactersInRangeWithTextField:textField withCellItem:withCellItem];
		};
        cell.endEdtingBlock = ^(ConItem *item) {
            if (indexPath.row == 0) {
                weakSelf.productModel.productName = item.contenText;
            } else if (indexPath.row == 2) {
                weakSelf.productModel.totalNumber = item.contenText;
                !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
            }
            
        };
        return cell;
    }
 
    BXSMachiningDBCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSMachiningDBCell cellID]];
    NSMutableArray *dsArr = _productModel.itemList[0].dsArray;
    BXSDSModel *model = dsArr[indexPath.row];
    cell.model = model;
    
    
    cell.clickDelectDBBlock = ^{
        if (dsArr.count > indexPath.row) {
            [dsArr removeObjectAtIndex:indexPath.row];
            
            !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
            [weakSelf reloadSuperTable];
        }
    };
    
    cell.needGetBottomDataBlock = ^{
        weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
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
    
    cell.clickColorCellBlock = ^{
        
        [weakSelf selectColor:indexPath];
    };
    
    
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
            if (seleteds.count > 0) {
                for (LLOutboundRightModel *aModel in seleteds) {
                    aModel.outgoingCount = aModel.number;
                }
                [dsModel.boundModelList addObjectsFromArray:seleteds];
            }
         
            [weakSelf reloadSuperTable];
            !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
            
        };
        [weakSelf.contentVC presentViewController:boundSeletedVC animated:YES completion:^{ }];
    };
    
    cell.clickDelectAKcBlock = ^{
        !weakSelf.getBottomDataBlock?:weakSelf.getBottomDataBlock();
       
        [weakSelf reloadSuperTable];
    };
    cell.addLabel.text = [NSString stringWithFormat:@"添加底步%ld",indexPath.row+1];
    return cell;
}

//MARK: ---- UITableViewDelegate ---
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self selectColor:indexPath];
        return;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [LineView lineViewOfHeight:10];
//    BXSMachiningDBHeaderfooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//
//    LZPurchaseItemListModel *item = _productModel.itemList[section];
//
//    header.colorlabel.text = [NSString stringWithFormat:@"颜色：%@",item.productColorName];
//    header.needLabel.text = [NSString stringWithFormat:@"需求量：%@",item.number];
//    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        return 50;
    }
    NSMutableArray *dsArr = _productModel.itemList[0].dsArray;
    BXSDSModel *model = dsArr[indexPath.row];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1f;
    }
    return 60.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
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
    CGFloat cellHeight = 230.0f;
    for (LZPurchaseItemListModel *pModel in _productModel.itemList) {
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.contentVC.mainTable reloadData];
    });
}

@end


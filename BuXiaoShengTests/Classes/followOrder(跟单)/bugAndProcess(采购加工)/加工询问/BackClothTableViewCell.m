//
//  BackClothTableViewCell.m
//  
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "BackClothTableViewCell.h"
@interface BackClothTableViewCell ()

@property (nonatomic, strong) NSArray *bottomArray;

@end
@implementation BackClothTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myTabelview.delegate = self;
    self.myTabelview.dataSource = self;
    
}

- (void)setListModel:(LZPurchaseDetailItemListModel *)listModel
{
    _listModel = listModel;
    if (listModel.bottomList.count == 0) {
        self.lineView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithHexString:@"D9EAFD"];
        _colorLabel.text = listModel.productColorName;
        _demandNumberLabel.text = listModel.number;
        _bottomArray = _listModel.bottomList;
        [self loadContactData];
    }else
    {
        _colorLabel.text = listModel.productColorName;
        _demandNumberLabel.text = listModel.number;
        _bottomArray = _listModel.bottomList;
        [self loadContactData];
    }
}

- (void)loadContactData
{
    self.myTableViewConstrait.constant = 88+_bottomArray.count *40;
    [self.myTabelview reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _bottomArray.count+2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        DibuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DibuTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DibuTableViewCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else if(indexPath.row == 1)
    {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleTableViewCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else
    {
        PinDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PinDetailTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PinDetailTableViewCell" owner:self options:nil] lastObject];
            
        }
        
        if (_bottomArray.count > 0) {
            
            cell.bottomModel = _bottomArray[indexPath.row - 2];
        }
        
        
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

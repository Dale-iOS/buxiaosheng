//
//  LLBackOrderCotentCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLBackOrderCotentCell.h"
#import "LLBackOrdeContentModel.h"
#import "LLBackOderDetailCell.h"
@interface LLBackOrderCotentCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end
@implementation LLBackOrderCotentCell

-(void)setDateModels:(NSMutableArray<NSMutableArray<LLBackOrdeContentModel *> *> *)dateModels {
    _dateModels = dateModels;
    [self.tableView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.dateModels.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.dateModels.count) {
        return 0;
    }
    return self.dateModels[section].count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.dateModels.count) {
        UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterSeletedView"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterSeletedView"];
            view.backgroundColor = [UIColor redColor];
        }
        return view;
    }
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLBackOderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLBackOderDetailCell"];
    cell.model = self.dateModels[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { //选择品名
        UIViewController * vc = [BXSTools viewWithViewController:self];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)foldBtnClick {
    self.block(self);
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = false;
       // _tableView.tableFooterView = [self tableViewFooterView];
        [_tableView registerClass:[LLBackOderDetailCell class] forCellReuseIdentifier:@"LLBackOderDetailCell"];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
        
    }
    return _tableView;
}


-(UIView*)tableViewFooterView  {
    
    UIView * tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    UIButton * addBtn = [UIButton new];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"fold"] forState:UIControlStateNormal];
    [tableViewFooterView addSubview: addBtn];
    [addBtn addTarget:self action:@selector(foldBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(tableViewFooterView);
    }];
    return tableViewFooterView;
}


@end

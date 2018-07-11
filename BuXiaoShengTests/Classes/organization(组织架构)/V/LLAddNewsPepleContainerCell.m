//
//  LLAddNewsPepleContainerCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddNewsPepleContainerCell.h"
#import "LLAddNewPeoleRoleModel.h"
#import "LLAddNewsPeopleCollectionViewCell.h"
#import "LLAuditMangerModel.h"
@interface LLAddNewsPepleContainerCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation LLAddNewsPepleContainerCell
{
    UICollectionView * _collectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LLAddNewPeoleRoleModel *)model {
    _model = model;
    [_collectionView reloadData];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 15; //行间距
        layout.minimumInteritemSpacing = 10; //..列间距
        layout.itemSize = CGSizeMake(LLScale_WIDTH(130), LLScale_WIDTH(130));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];
        [_collectionView registerClass:[LLAddNewsPeopleCollectionViewCell class] forCellWithReuseIdentifier:@"LLAddNewsPeopleCollectionViewCell"];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.model.itemList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLAddNewsPeopleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLAddNewsPeopleCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.model.itemList[indexPath.row];
    cell.block = ^(LLAddNewsPeopleCollectionViewCell *cell) {
        
        NSDictionary * param = @{
                                 @"buttonId":cell.model.id,
                                 @"companyId":[BXSUser currentUser].companyId,
                                 @"parentId":cell.model.parentId,
                                 @"memberId":_idModel.id
                                 };
        [BXSHttp requestGETWithAppURL:@"member/delete_role_button.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue]!=200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LLAddNewsdelete_role_buttonNotificationCenter" object:nil];
        } failure:^(NSError *error) {
            
        }];
    };
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);//分别为上、左、下、右
}

@end

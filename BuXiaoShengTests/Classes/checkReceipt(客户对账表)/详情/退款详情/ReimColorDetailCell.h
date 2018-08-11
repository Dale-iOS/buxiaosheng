//
//  ColorDetailCell.h
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReimColorDetailCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

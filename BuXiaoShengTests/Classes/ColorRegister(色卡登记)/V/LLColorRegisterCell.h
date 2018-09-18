//
//  LLColorRegisterCell.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextInputCell;
@interface LLColorRegisterCell : UITableViewCell
@property(nonatomic ,strong)TextInputCell * itemView;
@end

@class LLColorRegisterImageCell;
typedef void(^colorRegisterImageCellBlock)(LLColorRegisterImageCell * cell);
@interface LLColorRegisterImageCell:UICollectionViewCell
@property(nonatomic ,strong)UIImage * image;
@property(nonatomic ,strong)NSIndexPath * indexPath;
@property(nonatomic ,copy)colorRegisterImageCellBlock block;
@end

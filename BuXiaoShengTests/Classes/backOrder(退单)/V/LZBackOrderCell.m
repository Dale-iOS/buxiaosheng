//
//  LZBackOrderCell.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBackOrderCell.h"
#import "LZBackOrderItem.h"
#import "LZBackOrderGroup.h"

@interface LZBackOrderCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *foldBtn;
//新增一条按钮
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
//带有添加细码的cell标题视图
@property (weak, nonatomic) IBOutlet UILabel *titleLbThree;
//添加细码按钮
@property (weak, nonatomic) IBOutlet UIButton *addYardBtn;
//存放细码个数的内容视图
@property (weak, nonatomic) UIView *containerView;

@end

@implementation LZBackOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //cell的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //一个xib可以描述多个对象,当对象不存在时,再用SDAutoLayout自动布局,就奔溃,因此先判断对象是否存在
    if (_titleLb && _textField) {
        _titleLb.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).widthIs(110).heightIs(40);
        _textField.sd_layout.leftSpaceToView(_titleLb, 20).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 40).heightIs(40);
        [_textField addTarget:self action:@selector(handleTextChange) forControlEvents:UIControlEventEditingChanged];
    }
    
    if (_foldBtn && _addBtn) {
        _foldBtn.sd_layout.topSpaceToView(self.contentView, 10).centerXEqualToView(self.contentView).widthIs(30).autoWidthRatio(1.0);
        _addBtn.sd_layout.topSpaceToView(_foldBtn, 10).centerXEqualToView(_foldBtn).widthIs(100).heightIs(30);
    }
    
    if (_titleLbThree && _addYardBtn) {
        _titleLbThree.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).widthIs(200).heightIs(30);
        _addYardBtn.sd_layout.rightSpaceToView(self.contentView, 10).topEqualToView(_titleLbThree).widthIs(30).autoWidthRatio(1.0);
    }
}

static NSString *cellIdOne = @"LZBackOrderCellOne";
static NSString *cellIdTwo = @"LZBackOrderCellTwo";
static NSString *cellIdThree = @"LZBackOrderCellThree";
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView *)tableView cellType:(NSInteger)cellType {
    if (CellTypeNormal == cellType) {
        LZBackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdOne];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LZBackOrderCell" owner:nil options:nil] firstObject];
        }
        return cell;
    } else if (CellTypeBtn == cellType) {
        LZBackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdTwo];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"LZBackOrderCell" owner:nil options:nil][1];
        }
        return cell;
    } else if (CellTypeAddYard == cellType) {
        LZBackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdThree];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"LZBackOrderCell" owner:nil options:nil][2];
        }
        return cell;
    }
    
    return UITableViewCell.new;
}

- (void)setItem:(LZBackOrderItem *)item {
    _item = item;
    
    if ([BXSTools isEmptyString:item.detailTitle]) {
        _textField.placeholder = item.placeHolder;
        _textField.text = nil;
    } else {
        _textField.placeholder = nil;
        _textField.text = item.detailTitle;
        
    }
    _textField.textColor = item.detailColor;
    
    //开始自动布局
    if (CellTypeNormal == item.cellType) {
        //红色星号
        if (item.isMandatoryOption) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:item.textTitle];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
            _titleLb.attributedText = string;
        } else {
            _titleLb.text = item.textTitle;
        }
        
        //箭头
        if (item.showArrow) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            self.accessoryType = UITableViewCellAccessoryNone;
        }
        if (item.numericKeyboard) {
            _textField.keyboardType = UIKeyboardTypeNumberPad;
        } else {
            _textField.keyboardType = UIKeyboardTypeDefault;
        }
        [self setupAutoHeightWithBottomView:_titleLb bottomMargin:10];
    } else if (CellTypeBtn == item.cellType) {
        _addBtn.hidden = _group.isHiddenAddYard;
        if (_group.isHiddenAddYard) {
            [self setupAutoHeightWithBottomView:_foldBtn bottomMargin:10];
        } else {
            [self setupAutoHeightWithBottomView:_addBtn bottomMargin:10];
        }
    } else if (CellTypeAddYard == item.cellType) {
        _titleLbThree.text = item.textTitle;
        [self.containerView removeFromSuperview];
        self.containerView = nil;
        if (_group.itemStrings.count == 0) {
            [self setupAutoHeightWithBottomView:_titleLbThree bottomMargin:10];
        } else {
            self.containerView.
            sd_layout.leftEqualToView(_titleLbThree).topSpaceToView(_titleLbThree, 10).rightEqualToView(_addYardBtn);
            NSMutableArray *views = @[].mutableCopy;
            for (int i = 0; i < _group.itemStrings.count; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = i;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                [btn setTitle:_group.itemStrings[i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(handleItemAction:) forControlEvents:UIControlEventTouchUpInside];
                [_containerView addSubview:btn];
                btn.sd_layout.heightIs(30);
                [views addObject:btn];
            }
            [_containerView setupAutoWidthFlowItems:[views copy] withPerRowItemsCount:4 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
            [self setupAutoHeightWithBottomView:_containerView bottomMargin:10];
        }
    }
}

- (void)setGroup:(LZBackOrderGroup *)group {
    _group = group;
    NSString *imageName = group.isFold ? @"fold" : @"unfold";
    [_foldBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

#pragma mark - Events
//修改细码
- (void)handleItemAction:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(backOrderCell:modifyItemForIndexPath:index:)]) {
        [_delegate backOrderCell:self modifyItemForIndexPath:_indexPath index:btn.tag];
    }
}

//折叠
- (IBAction)handleFoldBtnAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(backOrderCell:btnClickType:forIndexPath:)]) {
        [_delegate backOrderCell:self btnClickType:BtnClickTypeFold forIndexPath:_indexPath];
    }
}

//新增一条
- (IBAction)handleAddYardAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(backOrderCell:btnClickType:forIndexPath:)]) {
        [_delegate backOrderCell:self btnClickType:BtnClickTypeAddYard forIndexPath:_indexPath];
    }
}

//添加细码
- (IBAction)handleAddItemAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(backOrderCell:btnClickType:forIndexPath:)]) {
        [_delegate backOrderCell:self btnClickType:BtnClickTypeAddItem forIndexPath:_indexPath];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //此处也就是只有显示箭头的cell,才需要跳转选择对应的选项
    if (_item.showArrow) {
        if ([_delegate respondsToSelector:@selector(backOrderCell:selectItemForIndexPath:)]) {
            [_delegate backOrderCell:self selectItemForIndexPath:_indexPath];
        }
    }
    return _item.isCanInput;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //此处只有出现添加细码的cell样式后,才需要回调
    if ((_item.mandatoryOption && _item.canInput && _group.items.count > 11) || _group.items.count == 6) {
         _item.detailTitle = [BXSTools isEmptyString:textField.text] ? @"" : textField.text;
        if ([_delegate respondsToSelector:@selector(backOrderCell:reloadForIndexPath:)]) {
            [_delegate backOrderCell:self reloadForIndexPath:_indexPath];
        }
    }
}

- (void)handleTextChange {
    if (_indexPath.section == 0 && _indexPath.row == 0) {
        if ([_delegate respondsToSelector:@selector(backOrderCell:popViewForIndexPath:textField:)]) {
            [_delegate backOrderCell:self popViewForIndexPath:_indexPath textField:_textField];
        }
    }
}

#pragma mark - Getter && Setter
- (UIView *)containerView {
    if (_containerView == nil) {
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

@end

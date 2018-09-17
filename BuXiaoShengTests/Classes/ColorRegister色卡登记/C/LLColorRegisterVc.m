//
//  LLColorRegisterVc.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  色卡登记页面

#import "LLColorRegisterVc.h"
#import "TextInputCell.h"
#import "LLColorRegistModel.h"
#import "LLColorRegisterCell.h"
#import "TZImagePickerController.h"
@interface LLColorRegisterVc ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)UIView * tableHeaderView;
@property(nonatomic ,strong)UIView * tableFooterView;
//备注
@property(nonatomic ,strong)TextInputCell * remakView;
//图片添加view
@property(nonatomic ,strong)UICollectionView * photoAddCollectionView;
@property(nonatomic ,strong)NSMutableArray<LLColorRegistModel*> * modelDatas;
@property(nonatomic ,strong)NSMutableArray <UIImage *> * imgsArray;

@property(nonatomic ,assign)NSInteger seletedImageIndex;

@end

@implementation LLColorRegisterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    self.title = @"色卡登记";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFooterView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLColorRegisterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLColorRegisterCell"];
    cell.itemView.lineView.hidden = true;
    cell.itemView.titleLabel.text = self.modelDatas[indexPath.row].leftStr;
    cell.itemView.contentTF.placeholder = self.modelDatas[indexPath.row].rightPlaceholder;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    if (self.modelDatas.count==1) {
        [LLHudTools showWithMessage:@"至少有一个品名"];
        return;
    }
    //删除数据，和删除动画
    [self.modelDatas removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.modelDatas enumerateObjectsUsingBlock:^(LLColorRegistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            obj.leftStr = @"品名";
            obj.rightPlaceholder = @"请输入品名";
        }else {
            obj.leftStr = [NSString stringWithFormat:@"品名%ld",idx];
            obj.rightPlaceholder = [NSString stringWithFormat:@"请输入品名%ld",idx];
        }
      
    }];
    [self.tableView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLColorRegisterImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLColorRegisterImageCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.image = self.imgsArray[indexPath.row];
    WEAKSELF
    cell.block = ^(LLColorRegisterImageCell *cell) {
        [weakSelf.imgsArray replaceObjectAtIndex:cell.indexPath.row withObject:[UIImage imageNamed:@"add_image"]];
        [collectionView reloadItemsAtIndexPaths:@[cell.indexPath]];
    };
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.seletedImageIndex = indexPath.row;
    UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
      WEAKSELF
    UIAlertAction * takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto:1];
    }];
    UIAlertAction * photoLib = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakSelf takePhoto:2];
    }];
    UIAlertAction * canle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alterVc addAction:takePhoto];
    [alterVc addAction:photoLib];
     [alterVc addAction:canle];
    [self.navigationController presentViewController:alterVc animated:true completion:nil];
}
//选择完成回调函数
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
         //获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
     NSData * picData = UIImageJPEGRepresentation(image, 0.5);
     UIImage * newImg = [[UIImage alloc] initWithData:picData];
     [self dismissViewControllerAnimated:true completion:^{
         [self.imgsArray replaceObjectAtIndex:self.seletedImageIndex withObject:newImg];
         [self.photoAddCollectionView reloadData];
     }];
     
        
     }

 //用户取消选择
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
         [self dismissViewControllerAnimated:YES completion:nil];
     }
/// MARK: ---- 选择相册和拍照的方法 1 拍照 2 相册
-(void)takePhoto:(NSInteger)index {
   
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]&&index ==1 ) {
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"摄像头访问受限" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertC addAction:action];
        return;
    }
        /// 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        /// 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            NSString *message = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
            UIAlertController * alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertC addAction:action];
            [self presentViewController:alertC animated:YES completion:nil];
           
            return;
        }
  
        
    //初始化UIImagePickerController类
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = true;
    //判断数据来源为相册
    picker.sourceType = index ==2 ? UIImagePickerControllerSourceTypeSavedPhotosAlbum:UIImagePickerControllerSourceTypeCamera;
      //设置代理
       picker.delegate = self;
        //打开相册
     [self presentViewController:picker animated:YES completion:nil];
}
/// MARK: ---- 导航右边按钮的点击
-(void)rightBarButtonItemClick {
    
}
/// MARK: ---- 新增一条的点击
-(void)addItemBtnClick {
    //默认进来初始化一条数据
    LLColorRegistModel * model = [LLColorRegistModel new];
    model.leftStr = [NSString stringWithFormat:@"品名%ld",self.modelDatas.count+1];
    model.rightPlaceholder = [NSString stringWithFormat:@"请输入品名%ld",self.modelDatas.count+1];
    [_modelDatas addObject:model];
    [self.tableView reloadData];
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        [_tableView registerClass:[LLColorRegisterCell class] forCellReuseIdentifier:@"LLColorRegisterCell"];
    }
    return _tableView;
}
-(UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 110)];
        _tableHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        NSArray * titles = @[@"客户名称",@"手机号码"];
        NSArray * placeholders = @[@"请输入客户名称",@""];
        [titles enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TextInputCell * itemView = [TextInputCell new];
            itemView.backgroundColor = [UIColor whiteColor];
            [self->_tableHeaderView addSubview:itemView];
            itemView.titleLabel.text = obj;
            itemView.contentTF.placeholder = placeholders[idx];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self->_tableHeaderView);
                make.top.equalTo(self->_tableHeaderView).offset(idx*45 + 10);
                make.height.mas_equalTo(45);
            }];
        }];
    }
    return _tableHeaderView;
}
-(UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 305)];
        _tableFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIView * addItemView = [UIView new];
        addItemView.backgroundColor = [UIColor whiteColor];
        [_tableFooterView addSubview:addItemView];
        [addItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self->_tableFooterView);
            make.height.mas_equalTo(45);
        }];
        UIButton * addItemBtn = [UIButton new];
        [addItemView addSubview:addItemBtn];
        [addItemBtn setBackgroundImage:[UIImage imageNamed:@"addbtn"] forState:UIControlStateNormal];
        [addItemBtn addTarget:self action:@selector(addItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [addItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(addItemView);
        }];
        //备注
        TextInputCell * remakView = [TextInputCell new];
        self.remakView = remakView;
        remakView.titleLabel.text = @"备注";
        remakView.contentTF.placeholder= @"请输入备注内容";
        remakView.backgroundColor = [UIColor whiteColor];
        [_tableFooterView addSubview:remakView];
        [remakView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_tableFooterView);
            make.top.equalTo(addItemView.mas_bottom).offset( 10);
            make.height.mas_equalTo(100);
        }];
        
        UIView * photoView = [UIView new];
        [_tableFooterView addSubview:photoView];
        photoView.backgroundColor = [UIColor whiteColor];
        [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self->_tableFooterView);
            make.top.equalTo(remakView.mas_bottom).offset(10);
        }];
        //图片
        UILabel * photoLable = [UILabel new];
        [photoView addSubview:photoLable];
        photoLable.text = @"图片";
        photoLable.textColor = CD_Text33;
        photoLable.font = FONT(14);
        [photoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photoView).offset(15);
            make.top.equalTo(photoView).offset(15);
        }];
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        self.photoAddCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.photoAddCollectionView.backgroundColor = [UIColor whiteColor];
        [photoView addSubview:self.photoAddCollectionView];
        self.photoAddCollectionView.delegate = self;
        self.photoAddCollectionView.dataSource = self;
        [self.photoAddCollectionView registerClass:[LLColorRegisterImageCell class] forCellWithReuseIdentifier:@"LLColorRegisterImageCell"];
        [self.photoAddCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(photoView);
            make.top.equalTo(photoLable .mas_bottom).offset(10);
            make.height.mas_equalTo(80);
        }];
    }
    return _tableFooterView;
}
-(NSMutableArray<LLColorRegistModel *> *)modelDatas {
    if (!_modelDatas) {
        _modelDatas = [NSMutableArray array];
        //默认进来初始化一条数据
        LLColorRegistModel * model = [LLColorRegistModel new];
        model.leftStr = @"品名";
        model.rightPlaceholder = @"请输入品名";
        [_modelDatas addObject:model];
    }
    return _modelDatas;
}
-(NSMutableArray<UIImage *> *)imgsArray {
    if (!_imgsArray) {
        _imgsArray = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            UIImage * image = [UIImage imageNamed:@"add_image"];
            [_imgsArray addObject:image];
        }
    }
    return _imgsArray;
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

//
//  MPUploadMomentImagesCell.m
//  TemplateTest
//
//  Created by ios on 2018/1/31.
//  Copyright © 2018年 caijingpeng.haowu. All rights reserved.
//

#import "MPUploadMomentImagesCell.h"
#import "NSArray+Utils.h"

@implementation MPUploadMomentImagesCell
@synthesize sv;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sv];
        [self.sv addSubview:self.addBtn];
        self.imageViews = [NSMutableArray array];
        
        [self updateImageViewsConstraints];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (UIScrollView *)sv
{
    if (!sv)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:(sv = scrollView)];
    }
    return sv;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundColor:UIColorFromRGB(0xeeeeee)];
        [_addBtn setImage:IMAGE(@"jiahao") forState:UIControlStateNormal];
        //        _addBtn.titleLabel.font = FONT(12);
        //        [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
        //        WEAKSELF;
        //        UILabel *titleLbael = [[UILabel alloc]init];
        //        titleLbael.font = FONT(12);
        //        titleLbael.textColor = UIColorFromRGB(0x878787);
        //        titleLbael.text = @"添加图片";
        //        titleLbael.textAlignment = NSTextAlignmentCenter;
        //        [_addBtn addSubview:titleLbael];
        //        [titleLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(weakSelf.addBtn);
        //            make.centerY.equalTo(weakSelf.addBtn).offset(UIAdaptiveRate(20));
        //            make.height.equalTo(@UIAdaptiveRate(20));
        //        }];
    }
    return _addBtn;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    WEAKSELF
    [self.sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}

- (void)updateImageViewsConstraints
{
    MPUploadImageView *lastImageView;
    
    float itemWidth=(APPWidth-5*5)/4;
    float itemHeight=itemWidth+5+5;
    for (int i = 0; i < self.imageViews.count; i++)
    {
        
        MPUploadImageView *curImageView = [self.imageViews pObjectAtIndex:i];
        //curImageView.delegate =self;
        MPUploadImageView *preImageView=nil;
        if(i%4==0){
            preImageView=nil;
        }else{
            preImageView = [self.imageViews pObjectAtIndex:i - 1];
        }
        
        NSInteger row=i/4;
        float top=row*itemHeight+5;
        
        if (preImageView == nil)
        {
            [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(5));
                make.top.equalTo(sv).offset(top);
                make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
                make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
            }];
        }
        else
        {
            [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preImageView.mas_right).with.offset(UIAdaptiveRate(5));
                make.top.equalTo(sv).offset(top);
                make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
                make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
            }];
        }
        
        /*
         
         if(i<4){
         
         MPUploadImageView *preImageView=nil;
         
         
         
         if(i%4==0){
         preImageView=nil;
         }else{
         preImageView = [self.imageViews pObjectAtIndex:i - 1];
         }
         
         NSInteger row=i/4;
         float top=row*itemHeight+5;
         
         
         
         
         
         if (preImageView == nil)
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         else
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(preImageView.mas_right).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         }else if(i>=4 && i<8){
         MPUploadImageView *preImageView=nil;
         if(i==4){
         preImageView=nil;
         }else{
         preImageView = [self.imageViews pObjectAtIndex:i - 1];
         }
         
         NSInteger row=i/4;
         float top=row*itemHeight+5;
         
         if (preImageView == nil)
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         else
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(preImageView.mas_right).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         
         
         
         }else{
         
         MPUploadImageView *preImageView=nil;
         if(i==8){
         preImageView=nil;
         }else{
         preImageView = [self.imageViews pObjectAtIndex:i - 1];
         }
         
         NSInteger row=i/4;
         float top=row*itemHeight+5;
         
         if (preImageView == nil)
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         else
         {
         [curImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(preImageView.mas_right).with.offset(UIAdaptiveRate(5));
         make.top.equalTo(sv).offset(top);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth)));
         }];
         }
         
         
         }
         */
        
        lastImageView = curImageView;
        
        
    }
    
    if (lastImageView == nil)
    {
        [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(10));
            make.top.equalTo(sv).offset(10);
            make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
            make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
        }];
    }
    else
    {
        
        
        NSInteger remainder=self.imageViews.count%4;
        if(remainder==0){
            [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(10));
                make.top.equalTo(lastImageView.mas_bottom).offset(10);
                make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
                make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
            }];
        }else{
            [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastImageView.mas_right).with.offset(10);
                make.top.equalTo(lastImageView.mas_top).offset(10);
                make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
                make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
            }];
        }
        
        
        /*
         
         if(self.imageViews.count<4){
         
         
         [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(lastImageView.mas_right).with.offset(10);
         make.top.equalTo(lastImageView.mas_top).offset(10);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         }];
         
         
         }else if(self.imageViews.count>=4 &&self.imageViews.count<8){
         if(self.imageViews.count==4){
         
         [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(10));
         make.top.equalTo(lastImageView.mas_bottom).offset(10);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         }];
         }else{
         
         [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(lastImageView.mas_right).with.offset(UIAdaptiveRate(10));
         make.top.equalTo(lastImageView.mas_top).offset(10);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         }];
         
         }
         
         }else if(self.imageViews.count>=8){
         if(self.imageViews.count==8){
         
         [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(sv.mas_left).with.offset(UIAdaptiveRate(10));
         make.top.equalTo(lastImageView.mas_bottom).offset(10);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         }];
         }else{
         
         [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(lastImageView.mas_right).with.offset(UIAdaptiveRate(10));
         make.top.equalTo(lastImageView.mas_top).offset(10);
         make.width.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         make.height.equalTo(@(UIAdaptiveRate(itemWidth-10)));
         }];
         
         }
         */
        
    }
    
    /*
     [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(lastImageView.mas_right).with.offset(10);
     //make.centerY.equalTo(sv);
     make.top.equalTo(lastImageView.mas_top);
     make.right.equalTo(sv.mas_right).with.offset(UIAdaptiveRate(-15));
     make.width.equalTo(@(UIAdaptiveRate(80)));
     make.height.equalTo(@(UIAdaptiveRate(80)));
     }];
     */
    // }
    
    //当已经上传了9张图片时,此时隐藏添加图片按钮
    if (self.imageViews.count == 9)
    {
        self.addBtn.hidden = YES;
    }
    else
    {
        self.addBtn.hidden = NO;
    }
}

#pragma mark - 添加MPUploadImageView

- (void)addImageView:(MPUploadImageView *)imageview {
    [self.imageViews addObject:imageview];
    [self.sv addSubview:imageview];
    [self updateImageViewsConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark - 删除指定的图片链接的MPUploadImageView

- (void)removeImageViewByUrl:(NSString *)url {
    MPUploadImageView *imageview = [self.imageViews objectOfProperty:@"imageUrl" value:url];
    [self.imageViews removeObject:imageview];
    [imageview removeFromSuperview];
    [self updateImageViewsConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - 更改指定图片链接的MPUploadImageView的图片链接

- (void)changeImageViewImageurlWithOriginUrl:(NSString *)originUrl NowUrl:(NSString *)nowUrl {
    MPUploadImageView *imageview = [self.imageViews objectOfProperty:@"imageUrl" value:originUrl];
    imageview.imageUrl = nowUrl;
}


@end

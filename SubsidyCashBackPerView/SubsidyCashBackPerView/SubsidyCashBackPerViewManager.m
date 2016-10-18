//
//  SubsidyCashBackPerViewManager.m
//  SubsidyCashBackPerView
//
//  Created by Jn_Kindle on 16/10/10.
//  Copyright © 2016年 HuaDa. All rights reserved.
//

#import "SubsidyCashBackPerViewManager.h"
#import "SubsidyCashBackPerView.h"

@interface SubsidyCashBackPerViewManager ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *maskingView;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIView *subsidyCashBackPerView;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
//确定按钮
@property (nonatomic, strong) UIButton *certainButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *selectDataArray;

@property (nonatomic, assign) NSInteger selectTag;



@end

@implementation SubsidyCashBackPerViewManager

+ (instancetype)sharedInstance {
    static SubsidyCashBackPerViewManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SubsidyCashBackPerViewManager new];
    });
    return instance;
}


-(UIView *)maskingView
{
    if (!_maskingView) {
        _maskingView = [[UIView alloc] initWithFrame:kScreenViewBounds];
        _maskingView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        _maskingView.userInteractionEnabled = YES;
        //手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskingViewHandleTap:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_maskingView addGestureRecognizer:tapGesture];
        
    }
    return _maskingView;
}


-(UIView *)subsidyCashBackPerView
{
    if (!_subsidyCashBackPerView) {
        _subsidyCashBackPerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenViewBounds.size.height*2/5, kScreenViewBounds.size.width, kScreenViewBounds.size.height*3/5)];
        _subsidyCashBackPerView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _subsidyCashBackPerView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,  kScreenViewBounds.size.width-10, 20)];
        
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenViewBounds.size.width-28, 10, 10, 10)];
        [_cancelButton setImage:[UIImage imageNamed:@"user_login_close"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
}


-(UIButton *)certainButton
{
    if (!_certainButton) {
        _certainButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenViewBounds.size.height*3/5-40, kScreenViewBounds.size.width, 40)];
        [_certainButton setTitle:@"确认" forState:UIControlStateNormal];
        _certainButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_certainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _certainButton.backgroundColor = [UIColor orangeColor];
        [_certainButton addTarget:self action:@selector(certainSelect:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _certainButton;
}

/**
 *  商品及返现比例item
 *
 *  @return 商品及返现比例collection
 */
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        //距离边缘的空隙
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //两个item水平的最小空隙(默认10)
        layout.minimumInteritemSpacing = 10;
        //两个item垂直方向的最小空隙(默认10)
        layout.minimumLineSpacing = 10;
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5+20+5,  kScreenViewBounds.size.width-10, kScreenViewBounds.size.height*3/5-5-20-5-45) collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.pagingEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[SubsidyCashBackPerCell class] forCellWithReuseIdentifier:@"SubsidyCashBackPerCell"];
    }
    return _collectionView;
}

-(void)showSubsidyCashBackPerViewWithSubsidyCashBackPerDataArray:(NSArray *)subsidyCashBackPerDataArray
{
    self.window = [UIApplication sharedApplication].keyWindow;
    //添加蒙版
    [self.window addSubview:self.maskingView];
    
    //添加补贴返现比例view
    [self.window addSubview:self.subsidyCashBackPerView];
    
    //添加标题
    [self.subsidyCashBackPerView addSubview:self.titleLabel];
    self.titleLabel.text = @"商品及返现比例";
    
    //添加取消选择按钮
    [self.subsidyCashBackPerView addSubview:self.cancelButton];
    
    //添加确认按钮
    [self.subsidyCashBackPerView addSubview:self.certainButton];
    
    //添加返现比例item
    self.selectTag = 0;
    self.selectDataArray = subsidyCashBackPerDataArray;
    [self.subsidyCashBackPerView addSubview:self.collectionView];
    
    
}



#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectDataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size={kScreenViewBounds.size.width/2-20, 30};
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SubsidyCashBackPerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubsidyCashBackPerCell" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    cell.titleLabel.text = self.selectDataArray[indexPath.row];
    
    //设置tag
    //cell.titleLabel.tag = 100+indexPath.row;
    
    ///*
    //选择
    if (indexPath.row == self.selectTag) {
        
        cell.titleLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        cell.titleLabel.textColor = [UIColor orangeColor];
        
    }else{
        
        cell.titleLabel.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        
    }
     //*/
    
    
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //赋值选择标记
    self.selectTag = indexPath.row;
    
    
    [self.collectionView reloadData];
    
    
    
    //[self hideSubsidyCashBackPerView];
    
}


//点击蒙版触发
- (void)maskingViewHandleTap:(UITapGestureRecognizer *)tap
{
    [self hideSubsidyCashBackPerView];
    
}

//取消选择
- (void)cancelSelect:(UIButton *)button
{
    [self hideSubsidyCashBackPerView];
}

//确认选择
- (void)certainSelect:(UIButton *)button
{
    [self.delegate didSelectItemAtIndex:self.selectTag];
    [self hideSubsidyCashBackPerView];
}

- (void)hideSubsidyCashBackPerView
{
    
    [self.maskingView removeFromSuperview];
    [self.subsidyCashBackPerView removeFromSuperview];
    
    [self setWindow:nil];
    
    [self setMaskingView:nil];
    [self setSubsidyCashBackPerView:nil];
    
    
}

@end

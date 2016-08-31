//
//  ViewController.m
//  CGYUICollectionViewFlowLayout
//
//  Created by 陈刚宇 on 16/8/30.
//  Copyright © 2016年 CGY. All rights reserved.
//

#define MAS_SHORTHAND
#import "ViewController.h"
#import "CGYFlowLayout.h"
#import "CGYCollectionViewCell.h"
#import "Masonry.h"

@interface ViewController ()<CGYFlowLayoutdataSource, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    
    CGYFlowLayout    *flowLayout;
    
    NSMutableArray   *_arrayList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    if (_arrayList == nil)
    {
        _arrayList = [[NSMutableArray alloc] init];
        for (NSInteger i =0 ;i <10 ;i++)
        {
            [_arrayList addObject:[NSString stringWithFormat:@"%d", 100+i*5]];
        }
    }
    
    if (flowLayout == nil)
    {
        flowLayout = [[CGYFlowLayout alloc] init];
        flowLayout.dataSource = self;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    if (_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CGYCollectionViewCell class] forCellWithReuseIdentifier:@"CGYCollectionViewCell"];
    }
    
    [self.view addSubview:_collectionView];
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
}

#pragma mark - CGYFlowLayoutdataSource
- (NSArray *)CGYFlowLayoutElementsSize
{
    return _arrayList;
}

- (CGYFlowLayoutType)CGYCollectionViewFlowLayoutType
{
    return CGYFlowLayoutTypeHorizontal;
}

- (NSInteger)CGYFlowLayoutVerticalNumber
{
    return 3;
}

- (CGFloat)CGYFlowLayoutWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)CGYFlowLayoutHorizontalCommonHeight
{
    return 30;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGYCollectionViewCell" forIndexPath:indexPath];
    
    [cell setLabel:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    return cell;
}

@end

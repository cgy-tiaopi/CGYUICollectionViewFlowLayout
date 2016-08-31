//
//  ViewController.m
//  CGYUICollectionViewFlowLayout
//
//  Created by 陈刚宇 on 16/8/30.
//  Copyright © 2016年 CGY. All rights reserved.
//

#import "ViewController.h"
#import "CGYFlowLayout.h"

@interface ViewController ()<CGYFlowLayoutdataSource>
{
    UICollectionView *_collectionView;
    
    CGYFlowLayout    *flowLayout;
    
    NSMutableArray   *_arraySize;
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
    if (flowLayout == nil)
    {
        flowLayout = [[CGYFlowLayout alloc] init];
        flowLayout.dataSource = self;
    }
    
    if (_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    }
}

#pragma mark - CGYFlowLayoutdataSource
- (NSArray *)CGYFlowLayoutElementsSize
{
    return _arraySize;
}

- (CGYFlowLayoutType)CGYCollectionViewFlowLayoutType
{
    return CGYFlowLayoutTypeVertical;
}

- (NSInteger)CGYFlowLayoutVerticalNumber
{
    return 3;
}

- (CGFloat)CGYFlowLayoutWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

@end

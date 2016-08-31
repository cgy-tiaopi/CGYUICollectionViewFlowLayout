//
//  CGYFlowLayout.m
//  CGYUICollectionViewFlowLayout
//
//  Created by 陈刚宇 on 16/8/30.
//  Copyright © 2016年 CGY. All rights reserved.
//

#import "CGYFlowLayout.h"

@interface CGYFlowLayout ()
{
    NSArray             *elementsSize;
    NSInteger           verticalNumber;
    
    CGYFlowLayoutType   flowLayoutType;
}

@end

@implementation CGYFlowLayout

- (id<CGYFlowLayoutdataSource>)dataSource
{
    return _dataSource;
}

- (void)setdataSource:(id<CGYFlowLayoutdataSource>)dataSource
{
    self.dataSource = dataSource;
}

#pragma mark - override UICollectionFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self collectionViewFlowLayoutSource];
    
    switch (flowLayoutType) {
        case CGYFlowLayoutTypeHorizontal:
        {
            [self flowLayoutHorizontal];
        }
            break;
        case CGYFlowLayoutTypeVertical:
        {
            [self flowLayoutVertical];
        }
        default:
            break;
    }
}

#pragma mark - CGYFlowLayout 数据源准备
- (void)collectionViewFlowLayoutSource
{
    if ([self.dataSource respondsToSelector:@selector(CGYCollectionViewFlowLayoutType)])
    {
        flowLayoutType = [self.dataSource CGYCollectionViewFlowLayoutType];
    }
    
    if (flowLayoutType == CGYFlowLayoutTypeVertical)
    {
        if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutVerticalNumber)])
        {
            verticalNumber = [self.dataSource CGYFlowLayoutVerticalNumber];
        }
        else
        {
            NSAssert([self.dataSource respondsToSelector:@selector(VerticalNumber)], @"required VerticalNumber");
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutElementsSize)])
    {
        elementsSize = [self.dataSource CGYFlowLayoutElementsSize];
    }
}

#pragma mark - CGYFlowLayout 布局方法实现
- (void)flowLayoutHorizontal
{
    
}

- (void)flowLayoutVertical
{
    
}

@end

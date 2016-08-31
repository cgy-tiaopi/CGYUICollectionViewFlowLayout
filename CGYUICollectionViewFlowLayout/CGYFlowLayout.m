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
    NSArray             *elementsSize;          //布局元素尺寸存储数组
    NSInteger           verticalNumber;         //竖直不规则布局列数
    NSMutableArray      *_arrayPosition;        //元素布局位置存储数组
    NSMutableDictionary *_dicVerticalHeight;    //对应列高度存储字典
    
    CGFloat             flowLayoutWidth;        //flowLayout的宽度
    
    CGFloat             horizontalElementsHeight;      //水平模式下每行元素的高度
    
    CGFloat             HorizontalHeight;
    
    CGYFlowLayoutType   flowLayoutType;
}

@end

@implementation CGYFlowLayout

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        if (nil == _arrayPosition)
        {
            _arrayPosition = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}


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
    
    switch (flowLayoutType) {                           //根据布局方式选择进行的方法
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
    if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutElementsSize)])
    {
        elementsSize = [self.dataSource CGYFlowLayoutElementsSize];
    }
    
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
            NSAssert([self.dataSource respondsToSelector:@selector(CGYFlowLayoutVerticalNumber)], @"required VerticalNumber");
        }
    }
    
    if (flowLayoutType == CGYFlowLayoutTypeHorizontal)
    {
        if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutHorizontalCommonHeight)])
        {
            horizontalElementsHeight = [self.dataSource CGYFlowLayoutHorizontalCommonHeight];
        }
        else
        {
            NSAssert([self.dataSource respondsToSelector:@selector(CGYFlowLayoutHorizontalCommonHeight)], @"required CGYFlowLayoutHorizontalCommonHeight");
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutElementsSize)])
    {
        elementsSize = [self.dataSource CGYFlowLayoutElementsSize];
    }
    
    if ([self.dataSource respondsToSelector:@selector(CGYFlowLayoutWidth)])
    {
        flowLayoutWidth = [self.dataSource CGYFlowLayoutWidth];
    }
    
    
}

#pragma mark - CGYFlowLayout 布局方法实现

//水平不规则布局方式实现
- (void)flowLayoutHorizontal
{
    [_arrayPosition removeAllObjects];
    
    CGFloat positionX = self.sectionInset.left;
    HorizontalHeight = self.sectionInset.top;
    CGFloat elementsWidth;
    
    for (NSInteger i = 0 ; i < [elementsSize count] ; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        elementsWidth = [[elementsSize objectAtIndex:i] floatValue];
        
        if ((positionX + self.sectionInset.right + elementsWidth) > flowLayoutWidth)
        {
            positionX = self.sectionInset.left;
            
            HorizontalHeight = HorizontalHeight + horizontalElementsHeight + self.minimumInteritemSpacing;
            
            attr.frame = CGRectMake(positionX, HorizontalHeight, elementsWidth, horizontalElementsHeight);
            
            positionX = positionX + elementsWidth + self.minimumLineSpacing;
        }
        else
        {
            attr.frame = CGRectMake(positionX, HorizontalHeight, elementsWidth, horizontalElementsHeight);
            
            positionX = positionX + elementsWidth + self.minimumLineSpacing;
        }
        
        [_arrayPosition addObject:attr];
        
    }
    
    HorizontalHeight = HorizontalHeight + horizontalElementsHeight;
}

//竖直不规则布局方式实现
- (void)flowLayoutVertical
{
    [_arrayPosition removeAllObjects];              //重新布局时移除所有
    
    CGFloat positionX;                              //元素布局X坐标
    CGFloat positionY;                              //元素布局Y坐标
    CGFloat elementsHeight;                         //元素高度
    NSInteger minHeightPosition;                    //最小高度行位置
    
    _dicVerticalHeight = [[NSMutableDictionary alloc] init];
    for(NSInteger i = 0 ; i < verticalNumber ; i++)
    {
        //初始化高度字典
        [_dicVerticalHeight setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    CGFloat elementsWidth = (flowLayoutWidth - self.minimumLineSpacing*(verticalNumber - 1)-self.sectionInset.left - self.sectionInset.right + 1)/verticalNumber;
    
    for (NSInteger i = 0 ; i < [elementsSize count] ; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        minHeightPosition = [self MinHeightPosition];
        positionX = self.sectionInset.left + (elementsWidth + self.minimumLineSpacing)*minHeightPosition;
        positionY =self.sectionInset.top + [[_dicVerticalHeight valueForKey:[NSString stringWithFormat:@"%ld",(long)minHeightPosition]] floatValue];
        elementsHeight = [[elementsSize objectAtIndex:i] floatValue];
        
        attr.frame = CGRectMake(positionX, positionY, elementsWidth, elementsHeight);
        
        [_dicVerticalHeight setValue:[NSNumber numberWithFloat:(positionY + elementsHeight + self.minimumInteritemSpacing)] forKey:[NSString stringWithFormat:@"%ld",(long)minHeightPosition]];
        
        [_arrayPosition addObject:attr];
    }
}

#pragma mark - 瀑布流高度相关操作

//获取当前最小高度所在的列
- (NSInteger)MinHeightPosition
{
    CGFloat minHeight = 10000000.0f;
    NSInteger position = 0;
    CGFloat temp;
    
    for (NSInteger i = 0 ; i < verticalNumber ; i++)
    {
        temp = [[_dicVerticalHeight valueForKey:[NSString stringWithFormat:@"%ld",(long)i]] floatValue];
        
        if (temp < minHeight)
        {
            minHeight = temp;
            position = i;
        }
    }
    
    return position;
}

//获取当前最大高度
- (CGFloat)maxHeightPosition
{
    CGFloat MaxHeight = 0.0f;
    CGFloat temp;
    
    for (NSInteger i = 0 ; i < verticalNumber ; i++)
    {
        temp = [[_dicVerticalHeight valueForKey:[NSString stringWithFormat:@"%ld",(long)i]] floatValue];
        
        if (temp > MaxHeight)
        {
            MaxHeight = temp;
        }
    }
    return MaxHeight;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"Position Count = %lu",(unsigned long)[_arrayPosition count]);
    
    return _arrayPosition;
}

- (CGSize)collectionViewContentSize
{
    if (flowLayoutType == CGYFlowLayoutTypeVertical)
    {
        return CGSizeMake(flowLayoutWidth, [self maxHeightPosition]);
    }
    else
    {
        return CGSizeMake(flowLayoutWidth, HorizontalHeight);
    }
}


@end

//
//  CGYFlowLayout.h
//  CGYUICollectionViewFlowLayout
//
//  Created by 陈刚宇 on 16/8/30.
//  Copyright © 2016年 CGY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGYFlowLayoutType)
{
    CGYFlowLayoutTypeHorizontal = 1,                        //水平显示模式，UICollectionView中的元素定宽不定高
    CGYFlowLayoutTypeVertical,                              //竖直现实模式，UICOllectionView中的元素定高不定宽
};

@protocol CGYFlowLayoutdataSource <NSObject>

@required

//指定UICollectionView的显示模式
- (CGYFlowLayoutType)CGYCollectionViewFlowLayoutType;

//水平模式下数组中传入的是每个元素的宽度，竖直模式下传入元素的高度
- (NSArray *)CGYFlowLayoutElementsSize;

//UICollectionView的宽度
- (CGFloat)CGYFlowLayoutWidth;

@optional

//在竖直模式下需要实现此方法，制定CollectionView中显示的列数
- (NSInteger)CGYFlowLayoutVerticalNumber;

@end

@interface CGYFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<CGYFlowLayoutdataSource>  dataSource;

@end

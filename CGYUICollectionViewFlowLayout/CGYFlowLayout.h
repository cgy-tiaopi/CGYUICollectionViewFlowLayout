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
    CGYFlowLayoutTypeHorizontal = 1,                        //水平显示模式，UICollectionView中的元素宽度不同，高度相同
    CGYFlowLayoutTypeVertical,                              //竖直现实模式，UICOllectionView中的元素宽度相同，高度不同
};

@protocol CGYFlowLayoutdataSource <NSObject>

@required

/**
 指定UICollectionView的显示模式

 @return CGYFlowLayoutType 瀑布流的展现方式
 */
- (CGYFlowLayoutType)CGYCollectionViewFlowLayoutType;

/**
 水平模式下数组中传入的是每个元素的宽度，竖直模式下传入元素的高度

 @return 包含Cell高度或宽度的数组
 */
- (NSArray *)CGYFlowLayoutElementsSize;

/**
 UICollectionView的宽度

 @return UICollectioncView的宽度
 */
- (CGFloat)CGYFlowLayoutWidth;

@optional
/**
 Cell高度不定时需要实现此方法，制定CollectionView中显示的列数
 
 @return UICollectionView的列数
 */
- (NSInteger)CGYFlowLayoutVerticalNumber;

/**
 Cell宽度不定时需要实现此方法，元素的自定义高度
 
 @return UICollectionView中每个元素的高度
 */
- (CGFloat)CGYFlowLayoutHorizontalCommonHeight;

@end

@interface CGYFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) id<CGYFlowLayoutdataSource>  dataSource;

@end

//
//  CGYCollectionViewCell.m
//  CGYUICollectionViewFlowLayout
//
//  Created by 陈刚宇 on 16/8/30.
//  Copyright © 2016年 CGY. All rights reserved.
//

#define MAS_SHORTHAND
#import "CGYCollectionViewCell.h"
#import "Masonry.h"

@interface CGYCollectionViewCell ()
{
    UILabel             *_labNumber;
}

@end

@implementation CGYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor blueColor];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    if (_labNumber == nil)
    {
        _labNumber = [[UILabel alloc] init];
        _labNumber.backgroundColor = [UIColor redColor];
    }

    [self addSubview:_labNumber];
    
    [_labNumber makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setLabel:(NSString *)string
{
    _labNumber.text = string;
}

@end

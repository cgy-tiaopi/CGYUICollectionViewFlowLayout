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
    UIImageView             *_imageView;
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
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
    }

    [self addSubview:_imageView];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

@end

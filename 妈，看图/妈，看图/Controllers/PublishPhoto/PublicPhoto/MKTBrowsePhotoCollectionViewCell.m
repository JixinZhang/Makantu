//
//  MKTBrowsePhotoCollectionViewCell.m
//  妈，看图
//
//  Created by ZhangBob on 1/19/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTBrowsePhotoCollectionViewCell.h"

@interface MKTBrowsePhotoCollectionViewCell()
{
    UIImageView *_imageView;
}

@end

@implementation MKTBrowsePhotoCollectionViewCell
@synthesize imageView = _imageView;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadImageView];
    }
    return self;
}



- (void)loadImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
}

@end

//
//  MKTPublicPhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTPublicPhotoVC.h"
#import "MKTBrowsePhotoRequest.h"
#import "MKTGlobal.h"
#import "AoiroSoraLayout.h"
#import "MKTBrowsePhotoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageVIew+WebCache.h"
#import "MKTUploadPicture.h"
#import "MKTShowPhotoVC.h"

@interface MKTPublicPhotoVC ()<MKTBrowsePhotoRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *pictureArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MKTPublicPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictureArray = [[NSMutableArray alloc] init];
    
    
    MKTBrowsePhotoRequest *request = [[MKTBrowsePhotoRequest alloc] init];
    [request sendBrowsePhotoRequestWithUserName:[MKTGlobal shareGlobal].user.userName delegate:self];
}


- (void)createCollectionView
{
    AoiroSoraLayout *layout = [[AoiroSoraLayout alloc] init];
    layout.interSpace = 2;
    layout.edgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    layout.colNum = 3;
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[MKTBrowsePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"MKTBrowsePhotoCollectionViewCell"];
    [self.view addSubview:_collectionView];
}

//确认每一个item的高
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    MKTUploadPicture *pictureInfo = self.pictureArray[indexPath.row];
    CGFloat width = [pictureInfo.width floatValue];
    CGFloat height = [pictureInfo.height floatValue];
    CGFloat widthOfItem = [[MKTGlobal shareGlobal].widthOfItem floatValue];
    return  (height/width*widthOfItem);

}
//确认section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//确认numberOfItem
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pictureArray.count;
}

//确认每一个Item的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKTBrowsePhotoCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MKTBrowsePhotoCollectionViewCell" forIndexPath:indexPath];
    
    MKTUploadPicture *pictureInfo = self.pictureArray[indexPath.row];
    NSString *urlString = pictureInfo.smallUrl;
    urlString = [NSString stringWithFormat:@"http://%@",urlString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [collectionCell.imageView sd_setImageWithURL:url];
    collectionCell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1];
    return collectionCell;
}

//选中都一个Item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了%ld",(long)indexPath.row);
    MKTShowPhotoVC *showPhotoVC = [[MKTShowPhotoVC alloc] init];
    showPhotoVC.picInfoArray = self.pictureArray;
    showPhotoVC.indexFromBrowsePhotoVC = indexPath.row;
    //    [self.navigationController pushViewController:showPhotoVC animated:YES];
    [self presentViewController:showPhotoVC animated:YES completion:nil];
}




- (void)browsePhotoRequestSuccess:(MKTBrowsePhotoRequest *)request array:(NSMutableArray *)array
{
    self.pictureArray = array;
    [self createCollectionView];
}

- (void)browsePhotoRequestFailed:(MKTBrowsePhotoRequest *)requset error:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

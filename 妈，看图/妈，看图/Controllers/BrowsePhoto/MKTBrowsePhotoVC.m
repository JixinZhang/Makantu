//
//  MKTBrowsePhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/21/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTBrowsePhotoVC.h"
#import "MKTBrowsePhotoRequest.h"
#import "MKTGlobal.h"
#import "AoiroSoraLayout.h"
#import "MKTBrowsePhotoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageVIew+WebCache.h"
#import "MKTUploadPicture.h"
#import "MKTShowPhotoVC.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
@interface MKTBrowsePhotoVC ()<MKTBrowsePhotoRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *pictureArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MKTBrowsePhotoVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.tag == 1) {
        [self showHUD:@"正在加载图片" isDim:NO];
        [self loadData];
        self.tag = 0;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictureArray = [[NSMutableArray alloc] init];
    _collectionView = [self collectionView];
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.view addSubview:_collectionView];
    
}

- (void)loadData
{
    MKTBrowsePhotoRequest *request = [[MKTBrowsePhotoRequest alloc] init];
    [request sendBrowsePhotoRequestWithAuthCode:[MKTGlobal shareGlobal].inputAuthCode delegate:self];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        AoiroSoraLayout *layout = [[AoiroSoraLayout alloc] init];
        layout.interSpace = 2;
        layout.edgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        layout.colNum = 3;
        layout.delegate = self;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[MKTBrowsePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"MKTBrowsePhotoCollectionViewCell"];
        return collectionView;
    }
    return _collectionView;
}

//- (void)createCollectionView
//{
//    AoiroSoraLayout *layout = [[AoiroSoraLayout alloc] init];
//    layout.interSpace = 2;
//    layout.edgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
//    layout.colNum = 3;
//    layout.delegate = self;
//    
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    [_collectionView registerClass:[MKTBrowsePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"MKTBrowsePhotoCollectionViewCell"];
//    [self.view addSubview:_collectionView];
//}





//确认每一个item的高
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    MKTUploadPicture *pictureInfo = self.pictureArray[indexPath.row];
    CGFloat width = [pictureInfo.width floatValue];
    CGFloat height = [pictureInfo.height floatValue];
    CGFloat widthOfItem = [[MKTGlobal shareGlobal].widthOfItem floatValue];
    CGFloat heightOfItem = height/width*widthOfItem;
    
    pictureInfo.width = [NSString stringWithFormat:@"%f",widthOfItem];
    pictureInfo.height = [NSString stringWithFormat:@"%f",heightOfItem];
    
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
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
    if (array) {
        self.pictureArray = array;
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [self hideHUD];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"该授权码无效，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"授权码";
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *inputAuthCodeTextField = alertController.textFields.firstObject;
            NSString *inputAuthCode = inputAuthCodeTextField.text;
            if ([inputAuthCode length]) {
                [MKTGlobal shareGlobal].inputAuthCode = inputAuthCode;
                MKTBrowsePhotoRequest *request = [[MKTBrowsePhotoRequest alloc] init];
                [request sendBrowsePhotoRequestWithAuthCode:[MKTGlobal shareGlobal].inputAuthCode delegate:self];
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"授权码不能为空" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}

- (void)browsePhotoRequestFailed:(MKTBrowsePhotoRequest *)requset error:(NSError *)error
{
    
}

     
 -(void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}
-(void)showHUDComplete:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = title;
    [self hideHUD];
}
     
-(void)hideHUD
{
    [self.hud hide:YES afterDelay:0.3];
}

     


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


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
#import "AppDelegate.h"
@interface MKTBrowsePhotoVC ()<MKTBrowsePhotoRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>
{
    UIAlertAction *okAlertAction;
}
@property (nonatomic, strong) NSMutableArray *pictureArray;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UINavigationItem *navigationBarTitle;

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
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 44)];
    self.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"共享"];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homepage"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomePage)];
    self.navigationBarTitle.rightBarButtonItem = homeButton;
    
    [self.navigationBar pushNavigationItem:self.navigationBarTitle animated:YES];
    
    
    
    [self.view addSubview:self.navigationBar];
    
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
        MKTUploadPicture *pictureMode = self.pictureArray[0];
        self.titleString = pictureMode.userName;
        self.navigationBarTitle.title = self.titleString;
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [self hideHUD];
    }else {
        [self hideHUD];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"该授权码无效，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"授权码";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isTextFieldEmpty:) name:UITextFieldTextDidChangeNotification object:textField];
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *inputAuthCodeTextField = alertController.textFields.firstObject;
            NSString *inputAuthCode = inputAuthCodeTextField.text;
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
            if ([inputAuthCode length]) {
                [MKTGlobal shareGlobal].inputAuthCode = inputAuthCode;
                MKTBrowsePhotoRequest *request = [[MKTBrowsePhotoRequest alloc] init];
                [request sendBrowsePhotoRequestWithAuthCode:[MKTGlobal shareGlobal].inputAuthCode delegate:self];
            }
            
        }];
        okAction.enabled = false;
        okAlertAction = okAction;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate loadBrowseOrPublicVC];
        }];
        
        [alertController addAction:okAlertAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}

- (void)browsePhotoRequestFailed:(MKTBrowsePhotoRequest *)requset error:(NSError *)error
{
    
}

- (void)isTextFieldEmpty:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if (textField.text.length) {
        okAlertAction.enabled = true;
    }else {
        okAlertAction.enabled = false;
    }
}


#pragma mark - MBProgressHUD
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

#pragma mark - back to home page
- (void)backToHomePage
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadBrowseOrPublicVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


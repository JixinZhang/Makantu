//
//  MKTShowPhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/21/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTShowPhotoVC.h"
#import "MKTUploadPicture.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MBProgressHUD.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define scrollViewWidth screenWidth
#define scrollViewHeight screenHeight - 64 - 37


@interface MKTShowPhotoVC ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIView *_contentView;
    UILabel *_pageLabel;
    unsigned int _index;
    UIPageControl *_pageControl;
    UILabel *_numberLabel;
}
@end

@implementation MKTShowPhotoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 20, 40, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    backButton.hidden = NO;
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 20, 60, 30)];
    _numberLabel.text = [NSString stringWithFormat:@"%d/%lu",self.indexFromBrowsePhotoVC+1,(unsigned long)self.picInfoArray.count];
    _numberLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_numberLabel];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, scrollViewWidth, scrollViewHeight)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(scrollViewWidth * self.picInfoArray.count, scrollViewHeight);
    _scrollView.pagingEnabled = YES;
//    _scrollView.maximumZoomScale = 3;
//    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth * self.picInfoArray.count, scrollViewHeight)];
    _contentView.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:_contentView];
    
    _index = self.indexFromBrowsePhotoVC;
    [_scrollView setContentOffset:CGPointMake(scrollViewWidth * _index, 0) animated:NO];
    
    //加载原图
    if (self.picInfoArray.count <= 3) {
        [self loadAllPicture:self.picInfoArray.count];
    }else {
        [self firstLoadAction:_index];
    }
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, _scrollView.frame.origin.y + scrollViewHeight, scrollViewWidth, 37)];
    _pageControl.numberOfPages = self.picInfoArray.count;
    _pageControl.currentPage = _index;
//    [self.view addSubview:_pageControl];



}

//如果self.picInfoArray.count<=3,加载所有照片
- (void)loadAllPicture:(unsigned int)index
{
    for (int i = 0; i < index; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * scrollViewWidth , 0, scrollViewWidth, scrollViewHeight)];
        view.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:view];
        //获取图片相关信息
        MKTUploadPicture *pictureInfo = [self.picInfoArray objectAtIndex:i];
        CGFloat widthOfPic = [pictureInfo.width floatValue];
        CGFloat heightOfPic = [pictureInfo.height floatValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (scrollViewWidth-scrollViewWidth*heightOfPic/widthOfPic) , scrollViewWidth, scrollViewWidth*heightOfPic/widthOfPic)];
        imageView.backgroundColor = [UIColor clearColor];
        
        //加载原图之前的placeholder
        UIImageView *placeHolder = [[UIImageView alloc] init];
        NSString *placeHolderUrlString = pictureInfo.smallUrl;
        placeHolderUrlString = [NSString stringWithFormat:@"http://%@",placeHolderUrlString];
        placeHolderUrlString = [placeHolderUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *placeHolderUrl = [NSURL URLWithString:placeHolderUrlString];
        [placeHolder sd_setImageWithURL:placeHolderUrl];
        
        //加载原图
        NSString *urlString = pictureInfo.originalUrl;
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        [imageView sd_setImageWithURL:url
                     placeholderImage:placeHolder.image];
        [view addSubview:imageView];    }
}

- (void)firstLoadAction:(unsigned int)index
{
    if (index <= 1) {
        [self loadFirstThreePicture];
    }
    else if (index >= self.picInfoArray.count-2){
        [self loadLastThreePicture];
    }
    else {
        [self loadThreePicture:index];
    }
}


- (void)loadFirstThreePicture
{
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * scrollViewWidth , 0, scrollViewWidth, scrollViewHeight)];
        view.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:view];
        //获取图片相关信息
        MKTUploadPicture *pictureInfo = [self.picInfoArray objectAtIndex:i];
        CGFloat widthOfPic = [pictureInfo.width floatValue];
        CGFloat heightOfPic = [pictureInfo.height floatValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (scrollViewWidth-scrollViewWidth*heightOfPic/widthOfPic) , scrollViewWidth, scrollViewWidth*heightOfPic/widthOfPic)];
        imageView.backgroundColor = [UIColor clearColor];
        
        //加载原图之前的placeholder
        UIImageView *placeHolder = [[UIImageView alloc] init];
        NSString *placeHolderUrlString = pictureInfo.smallUrl;
        placeHolderUrlString = [NSString stringWithFormat:@"http://%@",placeHolderUrlString];
        placeHolderUrlString = [placeHolderUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *placeHolderUrl = [NSURL URLWithString:placeHolderUrlString];
        [placeHolder sd_setImageWithURL:placeHolderUrl];
        
        //加载原图
        NSString *urlString = pictureInfo.originalUrl;
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        [imageView sd_setImageWithURL:url placeholderImage:placeHolder.image];
        [view addSubview:imageView];
    }
}

- (void)loadLastThreePicture
{
    for (int i = self.picInfoArray.count-1; i > self.picInfoArray.count-4; i--) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * scrollViewWidth , 0, scrollViewWidth, scrollViewHeight)];
        view.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:view];
        //获取图片相关信息
        MKTUploadPicture *pictureInfo = [self.picInfoArray objectAtIndex:i];
        CGFloat widthOfPic = [pictureInfo.width floatValue];
        CGFloat heightOfPic = [pictureInfo.height floatValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (scrollViewWidth-scrollViewWidth*heightOfPic/widthOfPic) , scrollViewWidth, scrollViewWidth*heightOfPic/widthOfPic)];
        imageView.backgroundColor = [UIColor clearColor];
        
        
        //加载原图之前的placeholder
        UIImageView *placeHolder = [[UIImageView alloc] init];
        NSString *placeHolderUrlString = pictureInfo.smallUrl;
        placeHolderUrlString = [NSString stringWithFormat:@"http://%@",placeHolderUrlString];
        placeHolderUrlString = [placeHolderUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *placeHolderUrl = [NSURL URLWithString:placeHolderUrlString];
        [placeHolder sd_setImageWithURL:placeHolderUrl];
        
        //加载原图
        NSString *urlString = pictureInfo.originalUrl;
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        [imageView sd_setImageWithURL:url placeholderImage:placeHolder.image];
        [view addSubview:imageView];
    }
}

- (void)loadThreePicture:(unsigned int)index
{
    
    for (int i = index-1 ;i <= index + 1;i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * scrollViewWidth , 0, scrollViewWidth, scrollViewHeight)];
        view.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:view];
        //获取图片相关信息
        MKTUploadPicture *pictureInfo = [self.picInfoArray objectAtIndex:i];
        CGFloat widthOfPic = [pictureInfo.width floatValue];
        CGFloat heightOfPic = [pictureInfo.height floatValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (scrollViewWidth-scrollViewWidth*heightOfPic/widthOfPic) , scrollViewWidth, scrollViewWidth*heightOfPic/widthOfPic)];
        imageView.backgroundColor = [UIColor clearColor];
        
        
        //加载原图之前的placeholder
        UIImageView *placeHolder = [[UIImageView alloc] init];
        NSString *placeHolderUrlString = pictureInfo.smallUrl;
        placeHolderUrlString = [NSString stringWithFormat:@"http://%@",placeHolderUrlString];
        placeHolderUrlString = [placeHolderUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *placeHolderUrl = [NSURL URLWithString:placeHolderUrlString];
        [placeHolder sd_setImageWithURL:placeHolderUrl];
        
        //加载原图
        NSString *urlString = pictureInfo.originalUrl;
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        [imageView sd_setImageWithURL:url placeholderImage:placeHolder.image];
        [view addSubview:imageView];
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollViewWidth;
    int i = _pageControl.currentPage;
    _numberLabel.text = [NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)self.picInfoArray.count];
    if (i>=1 && i<=self.picInfoArray.count-2) {
        [self loadThreePicture:i];
    }
}



- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}


-(void)hideHUD
{
    [self.hud hide:YES afterDelay:0.3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

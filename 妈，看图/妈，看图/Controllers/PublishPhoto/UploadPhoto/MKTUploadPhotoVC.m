//
//  MKTUploadPhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTUploadPhotoVC.h"
#import "MKTUploadPictureRequest.h"
#import "UpYun.h"
#import "MKTGlobal.h"
#import "AppDelegate.h"

@interface MKTUploadPhotoVC ()<MKTUploadPictureRequestDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation MKTUploadPhotoVC

-(instancetype)initWithPulishPhoto:(UIImage *)uploadPhoto
{
    self = [super init];
    if (self) {
        _uploadPhoto = uploadPhoto;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    CGFloat heightOfUploadPhoto = self.uploadPhoto.size.height;
    CGFloat widthOfUploadPhoto = self.uploadPhoto.size.width;
    
    self.uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-120, 72, 240, 240*heightOfUploadPhoto/widthOfUploadPhoto)];
    self.uploadImageView.image = self.uploadPhoto;
    
    [self.view addSubview:self.uploadImageView];
    
    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
//    titleLabel.text =@"发布照片";
//    titleLabel.textColor = [UIColor blackColor];
//    [self.navigationController.navigationBar addSubview:titleLabel];
    
    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(uploadButtonClicked:)];
    self.navigationItem.rightBarButtonItem = uploadButton;
    
    if (self.tag == 1) {
        [self MakeBackButton];
    }
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


-(void)MakeBackButton{
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    
}

-(void)cancelAction:(id)sender{
    
//    if (self.tag == 1) {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
//        
//    }else if (self.tag == 2 ){
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate loadPublishPhotoView:self];
}

- (IBAction)uploadButtonClicked:(id)sender
{
    UpYun *uploader = [[UpYun alloc] initWithBucket:@"makantu" andPassCode:@"qLD6lsR7dYayp3f0NCruvqy98ps="];
    NSData *uploadImageData = UIImageJPEGRepresentation(self.uploadImageView.image, 0.5);
    
    [uploader uploadFileWithData:uploadImageData useSaveKey:[self getSaveKey] completion:^(BOOL success, NSDictionary *result, NSError *error) {
        if (success) {
            NSLog(@"上传照片返回信息：%@",result);
            if ([result[@"message"] isEqualToString:@"ok"]) {
                
                [MKTGlobal shareGlobal].user.avatorImage = self.uploadImageView.image;
                MKTUploadPictureRequest *request = [[MKTUploadPictureRequest alloc]init];
                
                //上传照片
                [request sendUploadPictureRequestWithUserName:[MKTGlobal shareGlobal].user.userName
                                                     authCode:[MKTGlobal shareGlobal].user.authCode
                                                  originalUrl:result[@"url"]
                                                     smallUrl:result[@"url"]
                                                       height:result[@"image-height"]
                                                        width:result[@"image-width"]
                                                       remark:nil
                                                     delegate:self];
                
            }
        }else {
            NSLog(@"上传图像出现错误：%@",error);
        }
    }];
    
    uploader.progressBlock=^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        self.progressView.progressViewStyle = UIProgressViewStyleDefault;
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-100, self.uploadImageView.frame.origin.y + self.uploadImageView.frame.size.height + 8, 200, 5)];
        [self.view addSubview:self.progressView];
        [self.progressView setProgress:bytesWritten];
        
    };

}


-(NSString * )getSaveKey {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    NSDate *d = [NSDate date];
    return [NSString stringWithFormat:@"/%@/%ld/%ld/%.0f.jpg",[MKTGlobal shareGlobal].user.userName,[self getYear:d],[self getMonth:d],[[NSDate date] timeIntervalSince1970]];
    
    
    
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    
}

- (long)getYear:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    long year=[comps year];
    return year;
}

- (long)getMonth:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    long month = [comps month];
    return month;
}


- (void)showErrorMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void) UploadPictureRequestSuccess:(MKTUploadPictureRequest *)request picture:(MKTUploadPicture *)picture
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"上传成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        
        if (self.tag == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
        }else if (self.tag == 2 ){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void) UploadPictureRequestFailed:(MKTUploadPictureRequest *)request error:(NSError *)error
{
    
}

@end

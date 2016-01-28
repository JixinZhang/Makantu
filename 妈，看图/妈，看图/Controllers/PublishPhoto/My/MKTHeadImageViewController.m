//
//  MKTHeadImageViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTHeadImageViewController.h"
#import "MKTGlobal.h"
#import "UpYun.h"
#import "MKTMyViewController.h"
#import "MKTUploadPictureRequest.h"

@interface MKTHeadImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,MKTUploadPictureRequestDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end


@implementation MKTHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headImageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-100, 74, 200, 200)];
    self.headImageButton.titleLabel.textColor = [UIColor blackColor];
    self.headImageButton.titleLabel.numberOfLines = 3;
    [self.headImageButton setTitle:@"您还未上传头像,点击此处选择照片" forState:UIControlStateNormal];
    [self.headImageButton setImage:[MKTGlobal shareGlobal].user.avatorImage forState:UIControlStateNormal];
    [self.headImageButton addTarget:self
                             action:@selector(headImageButtonClicked)
                   forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.headImageButton];
    

}

- (void)headImageButtonClicked
{
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    CGSize imagesize = image.size;
    imagesize.height = 626;
    imagesize.width = 413;
    image = [self imageWithImage:image scaledToSize:imagesize];
    
    [self.headImageButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//对图片尺寸进行压缩
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

- (IBAction)changeHeadImageButtonClicked:(id)sender
{
    if (!self.headImageButton.imageView.image) {
        [self showErrorMessage:@"未选中照片"];
    }else {
        UpYun *uploader = [[UpYun alloc] initWithBucket:@"makantu" andPassCode:@"qLD6lsR7dYayp3f0NCruvqy98ps="];
        NSData *uploadImageData = UIImageJPEGRepresentation(self.headImageButton.imageView.image, 0.5);
        
        [uploader uploadFileWithData:uploadImageData useSaveKey:[self getSaveKey] completion:^(BOOL success, NSDictionary *result, NSError *error) {
            if (success) {
                NSLog(@"上传头像返回信息：%@",result);
                if ([result[@"message"] isEqualToString:@"ok"]) {
                    
                    [MKTGlobal shareGlobal].user.avatorImage = self.headImageButton.imageView.image;
                    MKTUploadPictureRequest *request = [[MKTUploadPictureRequest alloc]init];
                    
                    //上传头像
                    [request senduploadAvatorRequestWithUser_id:[MKTGlobal shareGlobal].user.user_id
                                                            Url:result[@"url"]
                                                       delegate:self];
                    
                }
            }else {
                NSLog(@"上传图像出现错误：%@",error);
            }
        }];
        
        uploader.progressBlock=^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
            self.progressView.progressViewStyle = UIProgressViewStyleDefault;
            self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-100, self.headImageButton.frame.origin.y + 200 + 8, 200, 5)];
            [self.view addSubview:self.progressView];
            [self.progressView setProgress:bytesWritten];
            
        };
    }
    
    
    
}

-(NSString * )getSaveKey {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    return [NSString stringWithFormat:@"/%@/avator/%.0f.jpg",[MKTGlobal shareGlobal].user.userName,[[NSDate date] timeIntervalSince1970]];
    
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    
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
        [self.navigationController popViewControllerAnimated:YES];

    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void) UploadPictureRequestFailed:(MKTUploadPictureRequest *)request error:(NSError *)error
{
    
}



@end





















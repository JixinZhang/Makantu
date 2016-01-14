//
//  MKTHeadImageViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTHeadImageViewController.h"
#import "MKTGlobal.h"
@interface MKTHeadImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end


@implementation MKTHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headImageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-100, 74, 200, 200)];
    self.headImageButton.titleLabel.textColor = [UIColor blackColor];
    self.headImageButton.titleLabel.numberOfLines = 3;
    [self.headImageButton setTitle:@"您还未上传头像,点击此处选择照片" forState:UIControlStateNormal];
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
    NSLog(@"更换成功");
}
@end

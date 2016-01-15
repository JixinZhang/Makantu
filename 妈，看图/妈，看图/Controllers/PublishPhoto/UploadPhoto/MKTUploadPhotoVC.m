//
//  MKTUploadPhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTUploadPhotoVC.h"

@interface MKTUploadPhotoVC ()

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
    CGFloat heightOfUploadPhoto = self.uploadPhoto.size.height;
    CGFloat widthOfUploadPhoto = self.uploadPhoto.size.width;
    self.uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-120, 72, 240, 240*heightOfUploadPhoto/widthOfUploadPhoto)];
    self.uploadImageView.image = self.uploadPhoto;
    
    [self.view addSubview:self.uploadImageView];
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

- (IBAction)uploadButtonClicked:(id)sender {
}
@end

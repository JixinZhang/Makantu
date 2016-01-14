//
//  MKTUploadPhotoVC.h
//  妈，看图
//
//  Created by ZhangBob on 1/14/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKTUploadPhotoVC : UIViewController

@property (nonatomic, strong) UIImageView *uploadImageView;
//存放从PickerController穿过来的图片
@property (nonatomic, strong) UIImage *uploadPhoto;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) UIImagePickerController *imagePicker;



-(instancetype)initWithPulishPhoto:(UIImage *)uploadPhoto;

- (IBAction)uploadButtonClicked:(id)sender;

@end

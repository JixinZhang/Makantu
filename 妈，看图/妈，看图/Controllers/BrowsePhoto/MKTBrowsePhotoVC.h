//
//  MKTBrowsePhotoVC.h
//  妈，看图
//
//  Created by ZhangBob on 1/21/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface MKTBrowsePhotoVC : UIViewController

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) NSInteger tag;

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)showHUDComplete:(NSString *)title;
-(void)hideHUD;


@end

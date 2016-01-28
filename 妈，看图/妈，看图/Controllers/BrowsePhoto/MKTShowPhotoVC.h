//
//  MKTShowPhotoVC.h
//  妈，看图
//
//  Created by ZhangBob on 1/21/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface MKTShowPhotoVC : UIViewController

@property (nonatomic, strong) NSMutableArray *picInfoArray;
@property (nonatomic) unsigned int indexFromBrowsePhotoVC;
@property (nonatomic, strong) MBProgressHUD *hud;

-(void)showHUD:(NSString *)title isDim:(BOOL)isDim;
-(void)hideHUD;

@end

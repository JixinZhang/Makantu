//
//  AppDelegate.h
//  妈，看图
//
//  Created by ZhangBob on 1/8/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)loadBrowseOrPublicVC;

- (void)loadLoginView;

- (void)loadBrowsePhotoView;

- (void)loadPublishPhotoView:(UIViewController *) viewController;

- (void)loadPickerControllerSourceTypeCamera;

- (void)loadPickerControllerSourceTypePhotoLibrary;

@end


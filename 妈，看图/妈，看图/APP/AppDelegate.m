//
//  AppDelegate.m
//  妈，看图
//
//  Created by ZhangBob on 1/8/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "AppDelegate.h"
#import "MKTLoginViewController.h"
#import "MKTBrowseOrPublicVC.h"
#import "MKTPublicPhotoVC.h"
#import "MKTMyViewController.h"

@interface AppDelegate ()<UINavigationBarDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) MKTLoginViewController *loginVC;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate

- (void)loadLoginView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MKTLoginAndRegister" bundle:[NSBundle mainBundle]];
    self.loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    self.window.rootViewController = self.loginVC;
}

- (void)loadPublishPhotoView:(UIViewController *)viewController
{
    MKTPublicPhotoVC *publicPhotoVC = [[MKTPublicPhotoVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:publicPhotoVC];
    
    nav.tabBarItem.title = @"已共享";
    
    
    
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"MKTMy" bundle:[NSBundle mainBundle]];
    MKTMyViewController *myVC = [myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    
    myVC.tabBarItem.title = @"我";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav,myVC];
    
    
    [viewController presentViewController:self.tabBarController animated:YES completion:nil];
    
    
    UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.window.frame.size.width/2-60, -25, 120, 50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
}

- (void)photoButtonClicked
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *fromPicker = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"选择拍照");
    }];
    
    UIAlertAction *fromLibrary = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"选择图库");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:fromPicker];
    [alertController addAction:fromLibrary];
    [alertController addAction:cancelAction];
    
    [self.tabBarController presentViewController:alertController animated:YES completion:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //进入app之后的root view controller
    
    MKTBrowseOrPublicVC *bOrpVC = [[MKTBrowseOrPublicVC alloc] init];
    self.window.rootViewController = bOrpVC;
    [self.window makeKeyAndVisible];
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

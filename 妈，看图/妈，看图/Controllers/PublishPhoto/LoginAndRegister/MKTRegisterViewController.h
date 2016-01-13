//
//  MKTRegisterViewController.h
//  妈，看图
//
//  Created by ZhangBob on 1/11/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKTRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonClicked:(UIButton *)sender;
- (IBAction)loginButtonClickde:(UIButton *)sender;
- (IBAction)touchDownAction:(id)sender;

@end

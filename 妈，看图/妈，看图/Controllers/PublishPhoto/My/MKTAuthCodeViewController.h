//
//  MKTAuthCodeViewController.h
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKTAuthCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *AuthCodeTextField;

- (IBAction)changeAuthCodeButtonClicked:(id)sender;

@end

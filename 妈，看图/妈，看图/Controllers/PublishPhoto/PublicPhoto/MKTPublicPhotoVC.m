//
//  MKTPublicPhotoVC.m
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTPublicPhotoVC.h"

@interface MKTPublicPhotoVC ()

@end

@implementation MKTPublicPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    label.text = @"显示照片流";
    [self.view addSubview:label];
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

@end

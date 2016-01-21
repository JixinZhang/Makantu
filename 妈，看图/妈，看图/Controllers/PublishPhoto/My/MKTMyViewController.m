//
//  MKTMyViewController.m
//  妈，看图
//
//  Created by ZhangBob on 1/13/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTMyViewController.h"
#import "MKTHeadImageViewController.h"
#import "MKTGlobal.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MKTMyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MKTMyViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.headImageView.image = [MKTGlobal shareGlobal].user.avatorImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headImageView.layer.cornerRadius = 30.0;
    self.headImageView.layer.masksToBounds = 30.0;
    
    NSString *urlString = [MKTGlobal shareGlobal].user.avatorURL;
    urlString = [NSString stringWithFormat:@"http://%@",urlString];
    NSURL *url = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.headImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [MKTGlobal shareGlobal].user.avatorImage = image;
    }];
    self.userNameLabel.text = [MKTGlobal shareGlobal].user.userName;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat header;
    if (section == 0) {
        header = 13.0;
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
//        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
//        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        pickerController.delegate = self;
//        [self presentViewController:pickerController animated:YES completion:nil];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MKTMy" bundle:nil];
        MKTHeadImageViewController *headImageVC = [storyboard instantiateViewControllerWithIdentifier:@"MKTHeadImageStoryboard"];
        [self.navigationController pushViewController:headImageVC animated:YES];
    }
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MKTMy" bundle:nil];
//    MKTHeadImageViewController *headImageVC = [storyboard instantiateViewControllerWithIdentifier:@"MKTHeadImageStoryboard"];
//    
//    [picker pushViewController:headImageVC animated:YES];
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

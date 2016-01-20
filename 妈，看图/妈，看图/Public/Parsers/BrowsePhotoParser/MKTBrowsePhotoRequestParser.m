//
//  MKTBrowsePhotoRequestParser.m
//  妈，看图
//
//  Created by ZhangBob on 1/19/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import "MKTBrowsePhotoRequestParser.h"
#import "MKTUploadPicture.h"

@implementation MKTBrowsePhotoRequestParser

- (NSMutableArray *)parserArray:(NSMutableArray *)array
{
    if ([[array class] isSubclassOfClass:[NSMutableArray class]]) {
        self.pictureArray = [[NSMutableArray alloc] init];
        for (id picDictionary in array) {
            MKTUploadPicture *pictureModel = [[MKTUploadPicture alloc] init];
            [pictureModel setValuesForKeysWithDictionary:picDictionary];
            [self.pictureArray addObject:pictureModel];
        }
    }
    return self.pictureArray;
}

@end

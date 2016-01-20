//
//  MKTBrowsePhotoRequestParser.h
//  妈，看图
//
//  Created by ZhangBob on 1/19/16.
//  Copyright © 2016 JixinZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKTBrowsePhotoRequestParser : NSObject

@property (nonatomic, strong) NSMutableArray *pictureArray;

- (NSMutableArray *)parserArray:(NSMutableArray *)array;

@end

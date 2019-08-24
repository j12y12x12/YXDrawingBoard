//
//  YXImageManager.h
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXImageManager : NSObject

+ (void)savePhotoWithData:(NSData *)data completion:(void (^)(NSError *error))completion;

+ (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion;

+ (void)savePhotoWithImageFilePath:(NSString *)imagePath completion:(void (^)(NSError *error))completion;


@end

NS_ASSUME_NONNULL_END

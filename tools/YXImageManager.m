//
//  YXImageManager.m
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import "YXImageManager.h"
#import <Photos/Photos.h>

@implementation YXImageManager

#pragma mark - 保存图片到相册，GIF
+ (void)savePhotoWithData:(NSData *)data completion:(void (^)(NSError *error))completion
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        options.shouldMoveFile = YES;
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        [request addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
        request.creationDate = [NSDate date];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (success && completion) {
                completion(nil);
            } else if (error) {
                NSLog(@"出错:%@",error.localizedDescription);
                if (completion) {
                    completion(error);
                }
            }
        });
    }];
}

+ (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if (imageData ==nil)
    {
        return;
    }
    [self savePhotoWithData:imageData completion:^(NSError * error) {
        
        if (completion)
        {
            completion(error);
        }
        
    }];
    
}

+ (void)savePhotoWithImageFilePath:(NSString *)imagePath completion:(void (^)(NSError *error))completion
{
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    
    if (imageData ==nil)
    {
        return;
    }
    
    [self savePhotoWithData:imageData completion:^(NSError * error) {
        
        if (completion)
        {
            completion(error);
        }
        
    }];
    
}


@end

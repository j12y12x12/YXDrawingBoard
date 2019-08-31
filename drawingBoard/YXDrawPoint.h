//
//  YXDrawPoint.h
//  drawingBoard
//
//  Created by jin on 2019/8/25.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXDrawPoint : NSObject

+ (instancetype)drawPoint:(CGPoint)point;

@property (nonatomic, strong) NSNumber * x;

@property (nonatomic, strong) NSNumber * y;

@end

NS_ASSUME_NONNULL_END

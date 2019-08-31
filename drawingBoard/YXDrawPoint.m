//
//  YXDrawPoint.m
//  drawingBoard
//
//  Created by jin on 2019/8/25.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import "YXDrawPoint.h"

@implementation YXDrawPoint

+ (instancetype)drawPoint:(CGPoint)point
{
    YXDrawPoint *drawPoint = [[YXDrawPoint alloc] init];
    drawPoint.x = @(point.x);
    drawPoint.y = @(point.y);
    return drawPoint;
}

@end

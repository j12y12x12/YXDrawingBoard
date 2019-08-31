//
//  YXBoardView.h
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, YXDrawingShapeType)
{
    YXDrawingShapeTypeCurve = 0,//曲线
    YXDrawingShapeTypeLine,//直线
    YXDrawingShapeTypeEllipse,//椭圆
    YXDrawingShapeTypeRect,//矩形
    
};



@interface YXBoardView : UIView

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, assign) YXDrawingShapeType shapType;//绘制样式

@end


#pragma mark - HBPath
@interface YXPath : NSObject

@property (nonatomic, strong) UIColor *pathColor;//画笔颜色
@property (nonatomic, assign) CGFloat lineWidth;//线宽
@property (nonatomic, assign) BOOL isEraser;//橡皮擦
@property (nonatomic, assign) YXDrawingShapeType shapType;//绘制样式
@property (nonatomic, copy) NSString *imagePath;//图片路径
@property (nonatomic, strong) UIBezierPath *bezierPath;


+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser;//初始化对象
- (void)pathLineToPoint:(CGPoint)movePoint WithType:(YXDrawingShapeType)shapeType;//画

@end

@interface YXDrawView : UIView

- (void)setBrush:(YXPath *)path;

@end

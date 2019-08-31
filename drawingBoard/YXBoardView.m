//
//  YXBoardView.m
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import "YXBoardView.h"
#import "YXDrawPoint.h"

@interface YXBoardView ()

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) NSMutableArray *tempPoints;

@property (nonatomic, strong) NSMutableArray *tempPath;

@property (nonatomic, strong) YXDrawView *drawView;

@property (nonatomic, strong) UIImageView *drawImage;

@end


@implementation YXBoardView

- (void)setShapType:(YXDrawingShapeType)shapType{
//    if (self.ise) {
//        return;
//    }
    _shapType = shapType;
}

- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}
- (NSMutableArray *)tempPoints{
    if (!_tempPoints) {
        _tempPoints = [NSMutableArray array];
    }
    return _tempPoints;
}
- (NSMutableArray *)tempPath{
    if (!_tempPath) {
        _tempPath = [NSMutableArray array];
    }
    return _tempPath;
}

- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] init];
    }
    return _backImage;
}
- (UIImageView *)drawImage
{
    if (!_drawImage) {
        _drawImage = [[UIImageView alloc] init];
        _drawImage.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _drawImage;
}

- (YXDrawView *)drawView{
    if (!_drawView) {
        _drawView = [YXDrawView new];
        _drawView.backgroundColor = [UIColor clearColor];

        
    }
    return _drawView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backImage];
        
        [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            
        }];

        [self addSubview:self.drawImage];
        
        [_drawImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            
        }];

        [self.drawImage addSubview:self.drawView];
        
        [_drawView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.drawImage);
            make.bottom.equalTo(self.drawImage);
            make.left.equalTo(self.drawImage);
            make.right.equalTo(self.drawImage);
            
        }];

//        __weak typeof(self) weakSelf = self;
//        //接受背景图片修改的通知
//        [[NSNotificationCenter defaultCenter] addObserverForName:kBoardImageDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//            NSString *str = [note.userInfo objectForKey:@"imageBoardName"];
//            weakSelf.backImage.image = [UIImage imageNamed:str];
//        }];
//
//        //        接受画笔修改的通知
//        [[NSNotificationCenter defaultCenter] addObserverForName:kBoardColorAndWidthDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//
////            _lineColor = [weakSelf.settingBoard getLineColor];
////            _lineWidth = [weakSelf.settingBoard getLineWidth];
//
//        }];
        
        
    }
    return self;
}



#pragma mark - 获取点击的位置
- (CGPoint)getTouchLocation:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
    
}

- (NSString *)getTimeString{
    
    NSDateFormatter  *dateformatter = nil;
    if (!dateformatter) {
        dateformatter = [[NSDateFormatter alloc] init];
    }
    
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    
    return [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self getTouchLocation:touches];
    
    YXPath *path = [YXPath pathToPoint:point pathWidth:30 isEraser:NO];
    
    path.pathColor = [UIColor greenColor];
    
    path.imagePath = [NSString stringWithFormat:@"%@.png",[self getTimeString]];
    
    [self.paths addObject:path];
    
    [self.tempPoints addObject:[YXDrawPoint drawPoint:point]];
    
//    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
//        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusBegin model:nil];
//    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint point = [self getTouchLocation:touches];
    
    YXPath *path = [self.paths lastObject];
    
    [path pathLineToPoint:point WithType:self.shapType];
    
//    if (self.ise) {
//        [self setEraseBrush:path];
//    }else{
//        [self.drawView setBrush:path];
//    }
    [self.drawView setBrush:path];

    [self.tempPoints addObject:[YXDrawPoint drawPoint:point]];
    
//    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
//        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusMove model:nil];
//    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
//    YXPath *path = [self.paths lastObject];
    
    UIImage *image = [self screenshot:self.drawImage];
    
    self.drawImage.image = image;
    
//    [self.drawView setBrush:nil];
    
//    NSData *imageData = UIImagePNGRepresentation(image);//UIImageJPEGRepresentation(image, 0.4);
//
//    NSString *filePath = [ThumbnailPath stringByAppendingPathComponent:path.imagePath];
//
//    BOOL isSave = [NSFileManager hb_saveData:imageData filePath:filePath];
//
//    if (isSave) {
//
//        NSLog(@"%@", [NSString stringWithFormat:@"保存成功: %@",filePath]);
//    }
//    HBDrawModel *model = [[HBDrawModel alloc] init];
//    model.paintColor = [_lineColor toColorString];
//    model.paintSize = @(_lineWidth);
//    model.isEraser = [NSNumber numberWithBool:path.isEraser];
//    model.pointList = self.tempPoints;
//    model.shapType = [NSNumber numberWithInteger:self.shapType];
//
//    if ([self.delegate respondsToSelector:@selector(drawBoard:drawingStatus:model:)]) {
//        [self.delegate drawBoard:self drawingStatus:HBDrawingStatusEnd model:model];
//    }
    
    //清空
//    [self.tempPoints removeAllObjects];
    
}

- (UIImage *)screenshot:(UIView *)shotView{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [shotView.layer renderInContext:context];
    
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return getImage;
}


@end

#pragma mark - HBPath
@interface YXPath()

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat pathWidth;

@end

@implementation YXPath

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser
{
    YXPath *path = [[YXPath alloc] init];
    path.beginPoint = beginPoint;
    path.pathWidth = pathWidth;
    path.isEraser = isEraser;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = pathWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:beginPoint];
    path.bezierPath = bezierPath;
    
    return path;
}


//HBDrawingShapeCurve = 0,//曲线
//HBDrawingShapeLine,//直线
//HBDrawingShapeEllipse,//椭圆
//HBDrawingShapeRect,//矩形
- (void)pathLineToPoint:(CGPoint)movePoint WithType:(YXDrawingShapeType)shapeType
{
    //判断绘图类型
    _shapType = shapeType;
    switch (shapeType) {
        case YXDrawingShapeTypeCurve:
        {
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case YXDrawingShapeTypeLine:
        {
            self.bezierPath = [UIBezierPath bezierPath];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
            [self.bezierPath moveToPoint:self.beginPoint];
            [self.bezierPath addLineToPoint:movePoint];
        }
            break;
        case YXDrawingShapeTypeEllipse:
        {
            self.bezierPath = [UIBezierPath bezierPathWithRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        case YXDrawingShapeTypeRect:
        {
            self.bezierPath = [UIBezierPath bezierPathWithOvalInRect:[self getRectWithStartPoint:self.beginPoint endPoint:movePoint]];
            self.bezierPath.lineCapStyle = kCGLineCapRound;
            self.bezierPath.lineJoinStyle = kCGLineJoinRound;
            self.bezierPath.lineWidth = self.pathWidth;
        }
            break;
        default:
            break;
    }
    //    self.shape.path = self.bezierPath.CGPath;
}


- (CGRect)getRectWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint orignal = startPoint;
    if (startPoint.x > endPoint.x) {
        orignal = endPoint;
    }
    CGFloat width = fabs(startPoint.x - endPoint.x);
    CGFloat height = fabs(startPoint.y - endPoint.y);
    return CGRectMake(orignal.x , orignal.y , width, height);
}

@end

@implementation YXDrawView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setBrush:(YXPath *)path
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    ((CAShapeLayer *)self.layer).path = path.bezierPath.CGPath;
    
    
}


@end


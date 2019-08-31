//
//  ViewController.m
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import "YXViewController.h"
#import "YXBoardView.h"

@interface YXViewController ()

@property (nonatomic, strong) YXBoardView *drawView;

@end

@implementation YXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.view addSubview:btn];

//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.height.mas_equalTo(150);
//        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//        make.right.equalTo(self.view).offset(-100);
//        make.left.equalTo(self.view).offset(100);
//
////        make.centerY.equalTo(self.view);
//    }];
//
//    btn.backgroundColor = [UIColor grayColor];
//    [btn setTitle:NSLocalizedString(@"haha",nil) forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    YXBoardView *boardView = [[YXBoardView alloc] init];
    
    self.drawView = boardView;
    [self.view addSubview:boardView];
    
    self.drawView.backImage.image = [UIImage imageNamed:@"back_01.jpg"];

//    boardView.backgroundColor = [UIColor yellowColor];
    [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.height.mas_equalTo(self.view.safeAreaLayoutGuide);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);

        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        
        //        make.centerY.equalTo(self.view);
    }];
    
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

//
//  ViewController.m
//  drawingBoard
//
//  Created by jin on 2019/8/24.
//  Copyright © 2019 yxdraw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(150);
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.centerY.equalTo(self.view);
    }];
    
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:NSLocalizedString(@"haha",nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}


@end

//
//  ViewController.m
//  AppTerminate
//
//  Created by ma qi on 2020/7/23.
//  Copyright © 2020 ma qi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self MQ_AddBtn];
}

- (void)MQ_AddBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"AppDelegate" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick:(UIButton *)sender {
    
}


@end

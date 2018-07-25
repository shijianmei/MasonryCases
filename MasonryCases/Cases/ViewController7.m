//
//  ViewController7.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/24.
//  Copyright © 2018 Jianmei. All rights reserved.
//
//
#import "ViewController7.h"

@interface ViewController7 ()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) MASConstraint *bottomCon;
@end

@implementation ViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    self.growingButton.backgroundColor = [UIColor redColor];
    [self.growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        self.bottomCon =  make.bottom.mas_equalTo(-350);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onGrowButtonTaped:(UIButton *)sender {
      
    [UIView animateWithDuration:1 animations:^{
        [self.bottomCon setOffset:0];
        [self.view layoutIfNeeded];
    }];
}

@end

//
//  ViewController1.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/17.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "ViewController1.h"
#import <Masonry.h>

@interface ViewController1 ()
@property (strong, nonatomic) UILabel *DescLab;
@property (nonatomic , strong)UIView *contentView;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initViews {
    _DescLab = [UILabel new];
    _DescLab.text = @"并排两个label，宽度由内容决定。父级View宽度不够时，省略左边label的后面的内容";
    _DescLab.textColor = [UIColor blackColor];
    _DescLab.numberOfLines = 2;
    [self.view addSubview:_DescLab];
    [_DescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(UI_NAVIGATION_BAR_HEIGHT +30);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.DescLab.mas_bottom).mas_offset(30);
        make.left.right.mas_equalTo(self.DescLab);
        make.height.mas_equalTo(50);
    }];
    
    _label1 = [UILabel new];
    _label1.backgroundColor = [UIColor yellowColor];
    _label1.text = @"label,";
    
    _label2 = [UILabel new];
    _label2.backgroundColor = [UIColor greenColor];
    _label2.text = @"label,";
    
    [_contentView addSubview:_label1];
    [_contentView addSubview:_label2];
    UIStepper *leftStepper = [UIStepper new];
    leftStepper.tag = 0;
    [leftStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:leftStepper];
    [leftStepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(30);
    }];
    
    UIStepper *rightStepper = [UIStepper new];
    rightStepper.tag = 1;
    [self.view addSubview:rightStepper];
    [rightStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [rightStepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-30);
        make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(30);
    }];
#pragma mark - 关键代码
    // label1: 位于左上角
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.left.equalTo(self.contentView.mas_left).with.offset(2);
        make.height.equalTo(@40);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).with.offset(2);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        
        make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-10);
        make.width.mas_greaterThanOrEqualTo(45);
        
        //只设置高度40
        make.height.equalTo(@40);
    }];
}

- (void)stepperValueChanged:(UIStepper *)sender {
    
    switch (sender.tag) {
        case 0:
            _label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 1:
            _label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        default:
            break;
    }
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [NSMutableString new];
    
    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"label,"];
    }
    
    return ret.copy;
}
@end

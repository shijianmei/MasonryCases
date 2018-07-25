//
//  ViewController3.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/20.
//  Copyright © 2018 Jianmei. All rights reserved.
//
/**
    动态居中
 */
#import "ViewController3.h"
static const CGFloat IMAGE_SIZE = 50;

@interface ViewController3 ()
@property (strong, nonatomic) UILabel *DescLab;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *imageViews;
@property (strong, nonatomic) NSMutableArray *widthConstraints;
@property (strong, nonatomic) NSArray *imageNames;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageViews = [NSMutableArray new];
    _widthConstraints = [NSMutableArray new];
    _imageNames = @[@"1", @"2", @"3"];
    
    [self initContainerView];
    [self initViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContainerView {
    _DescLab = [UILabel new];
    _DescLab.text = @"多个视图动态居中,当隐藏或显示仍然动态居中";
    _DescLab.textColor = [UIColor blackColor];
    _DescLab.numberOfLines = 2;
    [self.view addSubview:_DescLab];
    [_DescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(UI_NAVIGATION_BAR_HEIGHT +30);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    _containerView = [UIView new];
    [self.view addSubview:_containerView];
    _containerView.backgroundColor = [UIColor grayColor];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //只设置高度，宽度由子View决定
        make.height.equalTo(@(IMAGE_SIZE));
        //水平居中
        make.centerX.equalTo(self.view.mas_centerX);
        //距离父View顶部200点
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
}

- (void)initViews {
    //循环创建、添加imageView
    for (NSUInteger i = 0; i < _imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNames[i]]];
        [_imageViews addObject:imageView];
        [_containerView addSubview:imageView];
    }
    
    //设定大小
    CGSize imageViewSize = CGSizeMake(IMAGE_SIZE, IMAGE_SIZE);
    
    //分别设置每个imageView的宽高、左边、垂直中心约束，注意约束的对象
    //每个View的左边约束和左边的View的右边相等=。=，有点绕口...
    
    UIView __block *lastView = nil;
    MASConstraint __block *widthConstraint = nil;
    NSUInteger arrayCount = _imageViews.count;
    [_imageViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高固定
            widthConstraint = make.width.equalTo(@(imageViewSize.width));
            make.height.equalTo(@(imageViewSize.height));
            //左边约束
            make.left.equalTo(lastView ? lastView.mas_right : view.superview.mas_left);
            //垂直中心对齐
            make.centerY.equalTo(view.superview.mas_centerY);
            //设置最右边的imageView的右边与父view的最有对齐
            if (idx == arrayCount - 1) {
                make.right.equalTo(view.superview.mas_right);
            }
            
            [self.widthConstraints addObject:widthConstraint];
            lastView = view;
        }];
    }];
    
    UISwitch *switchBtn = [[UISwitch alloc]init];
    [self.view addSubview:switchBtn];
    [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_right).mas_offset(-30);
        make.top.mas_equalTo(self.containerView.mas_bottom).mas_offset(30);
    }];
}

-(void)switchAction:(UISwitch *)sender
{
    NSUInteger index = 2;
    MASConstraint *width = _widthConstraints[index];
    
    if (!sender.on) {
        width.equalTo(@(IMAGE_SIZE));
    } else {
        width.equalTo(@0);
    }
}
@end

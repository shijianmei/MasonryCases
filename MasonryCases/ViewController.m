//
//  ViewController.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/17.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "ViewController7.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.controllers = @[
                         [[ViewController1 alloc] initWithTitle:@"自适应变化的文本1"],
                         [[ViewController2 alloc] initWithTitle:@"自适应变化的文本2"],
                         [[ViewController3 alloc]initWithTitle:@"多个视图动态居中"],
                         [[ViewController4 alloc]initWithTitle:@"计算 table 高度的两种方式"],
                         [[ViewController5 alloc]initWithTitle:@"通过将约束表达式的结果赋值为局部变量或类属性，可以保持对特定约束的引用"],
                         [[ViewController6 alloc]initWithTitle:@"动画实现1"],
                         [[ViewController7 alloc]initWithTitle:@"动画实现2"],


                         ];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"CellIdentifier";
    UIViewController *viewController = self.controllers[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    cell.textLabel.text = viewController.title;
    cell.textLabel.numberOfLines = 2;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

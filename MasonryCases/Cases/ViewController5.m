//
//  ViewController5.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/24.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "ViewController5.h"



static CGFloat ParallaxHeaderHeight = 235;
static NSString *CellIdentifier = @"Cell";

@interface ViewController5 () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIImageView *parallaxHeaderView;
@property (strong, nonatomic) MASConstraint *parallaxHeaderHeightConstraint;
@end

@implementation ViewController5

- (void)dealloc {
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    [self initView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    return UITableViewAutomaticDimension;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue;
        if (contentOffset.y < -ParallaxHeaderHeight) {
            _parallaxHeaderHeightConstraint.equalTo(@(-contentOffset.y));
        }
        NSLog(@"%f",contentOffset.y);
    }
}

#pragma mark - Private methods

- (void)configTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(ParallaxHeaderHeight, 0, 0, 0);
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_tableView];
}

- (void)initView {
    _parallaxHeaderView = [UIImageView new];
    [self.view insertSubview:_parallaxHeaderView belowSubview:_tableView];
    _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxHeaderView.image = [UIImage imageNamed:@"header5"];
    
    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        self.parallaxHeaderHeightConstraint = make.height.equalTo(@(ParallaxHeaderHeight));
    }];
    
    // Add KVO
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

@end

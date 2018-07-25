//
//  ViewController4.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/24.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "ViewController4.h"
#import "TableViewCell4.h"
#import "Model4.h"

#define IOS_8_NEW_FEATURE_SELF_SIZING

@interface ViewController4 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (strong, nonatomic) TableViewCell4 *templateCell;


@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateData];
    [self initViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)initViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80.0f;
    [self.view addSubview:_tableView];
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
#endif
    
    // 注册Cell
    [_tableView registerClass:[TableViewCell4 class] forCellReuseIdentifier:NSStringFromClass([TableViewCell4 class])];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    return UITableViewAutomaticDimension;
#else
    
    if (!_templateCell) {
        _templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell4 class])];
        _templateCell.tag = -1000; // For debug dealloc
    }
    
    // 获取对应的数据
    Model4 *model = _data[indexPath.row];
    
    // 判断高度是否已经计算过
    if (model.cellHeight <= 0) {
        // 填充数据
        _templateCell.model = dataEntity;
        // 根据当前数据，计算Cell的高度，注意+1
        model.cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate: %ld, height: %g", (long) indexPath.row, model.cellHeight);
    } else {
        NSLog(@"Get cache: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    }
    
    return model.cellHeight;
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell4 class]) forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
    return cell;
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];
    
    for (int i = 0; i < 20; i++) {
        Model4 *dataEntity = [Model4 new];
        dataEntity.avatar = [UIImage imageNamed:[NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1]];
        dataEntity.title = [NSString stringWithFormat:@"Title: %d", i];
        dataEntity.content = [self getText:@"content-" withRepeat:i * 2 + 1];
        [tmpData addObject:dataEntity];
    }
    
    _data = tmpData;
}

- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }
    
    return tmpText;
}
@end

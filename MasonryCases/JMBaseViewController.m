//
//  JMBaseViewController.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/17.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "JMBaseViewController.h"

@interface JMBaseViewController ()

@end

@implementation JMBaseViewController

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (kIOSVersion >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}
@end

//
//  JMBaseViewController.h
//  MasonryCases
//
//  Created by Jianmei on 2018/7/17.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWeakObject(obj) __weak __typeof(obj) weakObject = obj;
#define kIOSVersion ((float)[[[UIDevice currentDevice] systemVersion] doubleValue])
@interface JMBaseViewController : UIViewController
- (instancetype)initWithTitle:(NSString *)title;
@end

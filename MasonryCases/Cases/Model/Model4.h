//
//  Model4.h
//  MasonryCases
//
//  Created by Jianmei on 2018/7/24.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model4 : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) UIImage *avatar;

// Cache
@property (assign, nonatomic) CGFloat cellHeight;
@end

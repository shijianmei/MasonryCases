//
//  TableViewCell4.m
//  MasonryCases
//
//  Created by Jianmei on 2018/7/24.
//  Copyright © 2018 Jianmei. All rights reserved.
//

#import "TableViewCell4.h"
#import "Model4.h"

@interface TableViewCell4()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end
@implementation TableViewCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(Model4 *)model
{
    _model = model;
    
    _avatarImageView.image = model.avatar;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
}

#pragma mark - Private methods

- (void)initView {
    self.tag = 1000;
    
    // Avatar头像
    _avatarImageView = [UIImageView new];
    [self.contentView addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@44);
        make.left.and.top.equalTo(self.contentView).with.offset(4);
    }];
    
    // Title - 单行
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@22);
        make.top.equalTo(self.contentView).with.offset(4);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
    }];
    
    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 44 - 4 * 3; // 44 = avatar宽度，4 * 3为padding
    
    // Content - 多行
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(_avatarImageView.mas_right).with.offset(4);
        make.right.equalTo(self.contentView).with.offset(-4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}


@end

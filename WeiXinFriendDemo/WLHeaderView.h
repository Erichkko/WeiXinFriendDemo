//
//  WLHeaderView.h
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/12.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLComment;


typedef void(^TapBlock)(NSInteger index,NSArray *dataSources);

@interface WLHeaderView : UITableViewHeaderFooterView


/** 头像*/
@property (nonatomic,strong) UIImageView *avatarIv;

/** 用户名*/
@property (nonatomic,strong) UILabel *userNameLabel;

/** 时间戳*/
@property (nonatomic,strong) UILabel *timeStampLabel;

/** 发表的文字*/
@property (nonatomic,strong) UILabel *commnentTextLabel;

/** 展开全文*/
@property (nonatomic,strong) UIButton *commentBTn;

/** 数据模型*/
@property (nonatomic,strong) WLComment *commentModel;


@property (nonatomic,copy) TapBlock tapBlock;
@end

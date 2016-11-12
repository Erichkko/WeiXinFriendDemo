//
//  WLSpeedDial.h
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/12.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TapBlock)(NSInteger index,NSArray *dataSource);
@interface WLSpeedDial : UIView

/** 九宫格的数据源*/
@property (nonatomic,strong) NSArray *dataSources;

/** 回调block*/
@property (nonatomic,copy) TapBlock tapBlock;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlock)tapBlock;

/** 配置图片的宽度*/
+ (CGFloat)imageWidth;

/** 配置图片的高度*/
+ (CGFloat)imageHeight;
@end 

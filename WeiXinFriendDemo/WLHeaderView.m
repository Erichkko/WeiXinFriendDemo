//
//  WLHeaderView.m
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/12.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import "WLHeaderView.h"
#import "WLComment.h"
#import "UIImageView+WebCache.h"
#import "WLSpeedDial.h"
@implementation WLHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //添加头像
        self.avatarIv = [[UIImageView alloc] init];
        self.avatarIv.frame = CGRectMake(kGAP, kGAP, 50, 50);
        self.avatarIv.layer.cornerRadius = self.avatarIv.frame.size.width * 0.5;
        self.avatarIv.layer.masksToBounds = YES;
        [self addSubview:self.avatarIv];
        //添加用户名
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.frame = CGRectMake(self.avatarIv.frame.size.width + self.avatarIv.frame.origin.x +kGAP, self.avatarIv.frame.origin.y,SCREEN_WIDTH - 2 * kGAP - self.avatarIv.frame.size.width , self.avatarIv.frame.size.height * 0.5);
        
        self.userNameLabel.numberOfLines = 0;
        self.userNameLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.userNameLabel];
        //添加时间戳
        self.timeStampLabel = [[UILabel alloc] init];
        
         self.timeStampLabel.frame = CGRectMake(self.userNameLabel.frame.origin.x, self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height , self.userNameLabel.frame.size.width, self.userNameLabel.frame.size.height );
        
        self.timeStampLabel.numberOfLines = 0;
        self.timeStampLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.timeStampLabel];
        //添加发表的文字
        self.commnentTextLabel = [[UILabel alloc] init];
        self.commnentTextLabel.numberOfLines = 0;
        [self addSubview:self.commnentTextLabel];
    }
    return self;
}

- (void)setCommentModel:(WLComment *)commentModel
{
    _commentModel = commentModel;
    //计算发表文字的高度
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]
                                 };
    CGSize size = [commentModel.commentText boundingRectWithSize:CGSizeMake(self.userNameLabel.frame.size.width - 2 * kGAP, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.commnentTextLabel.frame = CGRectMake(self.userNameLabel.frame.origin.x, CGRectGetMaxY(self.timeStampLabel.frame) + kGAP, self.userNameLabel.frame.size.width - 2 * kGAP, size.height + 2 * kGAP);
    
    //解决图片重复利用的问题
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[WLSpeedDial class]]) {
            [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [view removeFromSuperview];
        }
    }
    
    //计算九宫格的高度
    CGFloat SpeedDialH = 0;
    NSUInteger picCount =commentModel.commentPics.count;
    if (picCount <= 3) {
        SpeedDialH = [WLSpeedDial imageHeight] + kGAP;
    }else if(picCount <= 6){
        SpeedDialH = ([WLSpeedDial imageHeight] + kGAP) * 2;
    }else if(picCount <=9){
        SpeedDialH = ([WLSpeedDial imageHeight] + kGAP) * 3;
    }
    //初始化九宫格
    if (commentModel.commentPics.count) {
        self.speedDial = [[WLSpeedDial alloc] initWithFrame:CGRectMake(self.commnentTextLabel.frame.origin.x, CGRectGetMaxY(self.commnentTextLabel.frame), self.commnentTextLabel.frame.size.width, SpeedDialH) dataSource:commentModel.commentPics completeBlock:^(NSInteger index, NSArray *dataSource) {
//            NSLog(@"index == %zd",index);
            if (self.tapBlock) {
                self.tapBlock(index,dataSource);
            }
        }];
        [self addSubview:self.speedDial];
        //设置自身的Frame
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kGAP + self.avatarIv.frame.size.height + kGAP + self.commnentTextLabel.frame.size.height + kGAP + SpeedDialH);
    }else{
        //设置自身的Frame
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kGAP + self.avatarIv.frame.size.height + kGAP + self.commnentTextLabel.frame.size.height + kGAP );
    }
    
    //设置各个控件的文字
    [self.avatarIv setImageWithURL:[NSURL URLWithString:commentModel.avatar] placeholderImage:nil];
    self.userNameLabel.text = commentModel.userName;
    self.timeStampLabel.text = commentModel.timeStamp;
    self.commnentTextLabel.text = commentModel.commentText;
    
}
@end

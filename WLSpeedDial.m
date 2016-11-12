//
//  WLSpeedDial.m
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/12.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import "WLSpeedDial.h"
#import "UIImageView+WebCache.h"


@implementation WLSpeedDial

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlock )tapBlock
{
    if (self = [super initWithFrame:frame]) {
        CGFloat imageOrignX = 0;
        CGFloat imageOrignY = 0;
        for (NSUInteger i = 0; i <dataSource.count; i ++) {
            imageOrignX = ([WLSpeedDial imageWidth] + kGAP) * (i % 3);
            imageOrignY = (i/3)*([WLSpeedDial imageHeight] +kGAP);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageOrignX, imageOrignY, [WLSpeedDial imageWidth], [WLSpeedDial imageHeight])];
            if ([dataSource[i] isKindOfClass:[UIImage class]]) {
                imageView.image = dataSource[i];
            }else if ([dataSource[i] isKindOfClass:[NSString class]]){
                [imageView setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }else if([dataSource[i] isKindOfClass:[NSURL class]]){
                [imageView setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            self.dataSources = dataSource;
            self.tapBlock = tapBlock;
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            [self addSubview:imageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapImageAction:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        
    }
    return self;
}


- (void)singleTapImageAction:(UITapGestureRecognizer *)tapGesture{
    UIImageView *tapView = (UIImageView *)tapGesture.view;
    if (self.tapBlock) {
        NSLog(@"tag == %zd",tapView.tag);
        self.tapBlock(tapView.tag,self.dataSources);
    }
}

+ (CGFloat)imageWidth
{
    return (SCREEN_WIDTH - 5 * kGAP - 35 -50)/3;
}
+ (CGFloat)imageHeight
{
    return (SCREEN_HEIGHT - 5 * kGAP -35 - 50)/3;
}
@end

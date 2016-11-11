//
//  WLComment.h
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/11.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLComment : NSObject

/** avatar*/
@property (nonatomic,copy) NSString *avatar;
/** commentText*/
@property (nonatomic,copy) NSString *commentText;
/** timeStamp*/
@property (nonatomic,copy) NSString * timeStamp;
/** userName*/
@property (nonatomic,copy) NSString *userName;
/** commentReplys*/
@property (nonatomic,copy) NSArray *commentReplys;
/** avatar*/
@property (nonatomic,strong) NSArray *commentPics;




@end

//
//  WLViewController.m
//  WeiXinFriendDemo
//
//  Created by WangLong on 16/11/11.
//  Copyright © 2016年 WangLong. All rights reserved.
//

#import "WLViewController.h"
#import "WLComment.h"
#import "WLCommentCell.h"
#import "WLHeaderView.h"

@interface WLViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property (nonatomic,strong) UITableView *tableView;

/** dataSources*/
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation WLViewController

static NSString *cellId = @"commendCellId";
static NSString *headerId = @"commendheaderId";


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource  = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initTableView];
    [self downLoadDataFromNetWork];
}
//init Navigation
- (void)initNavigation{
    self.navigationItem.title = @"标题";
}

//init TableView
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"WLCommentCell" bundle:nil] forCellReuseIdentifier:cellId];
    [self.tableView registerClass:[WLHeaderView class] forHeaderFooterViewReuseIdentifier:headerId];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:self.tableView];
}

//处理网络数据
- (void)downLoadDataFromNetWork{
    NSDictionary *JSONDic =
    @{@"msg":@"成功" , @"code":@"10000" , @"data":@[
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111012109240.jpg" , @"userName":@"张三" ,@"timeStamp":@"刚刚", @"commentText":@"朋友网是一个真实的社交网络,在朋友网你能和同学、朋友、同事、校友、老乡保持亲密的联系,了解他们的最新状态;和好友一起分享照片、视频;和好友一起玩QQ农场、QQ" ,@"commentPics" :@[@"http://touxiang.qqzhi.com/uploads/2012-11/1111012109240.jpg" , @"http://touxiang.qqzhi.com/uploads/2012-11/1111012109240.jpg", @"http://touxiang.qqzhi.com/uploads/2012-11/1111005327156.jpg" ,@"http://touxiang.qqzhi.com/uploads/2012-11/1111111123827.jpg" ] , @"commentReplys":@[@"影片讲述了1957年秋天",@"你好",@"什么鬼东西",@"微信网页版怎么看朋友圈,微信朋友圈类似一个个人心情分享平台,您可以在微信朋友圈查看好友的朋友圈动态。但是,很多人想实现在网页上查看微信朋",@"Benny与Eve决定离开居住已久的小镇"]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111005327156.jpg" , @"userName":@"李四" ,@"timeStamp":@"一天以前", @"commentText":@"《朋友圈》是由帕特·奥康纳执导，克里斯·奥唐纳 、明妮·德里弗 等主演的爱情片。影片讲述了1957年秋天，Benny与Eve决定离开居住已久的小镇，在大学里她们巧遇小学同学Nan，并因而结识了Jack。后来Jack正式向Benny展开猛烈追求，两人便热enny与Eve决定离开居住已久的小镇，在大学里她们巧遇小学同学Nan，并因而结识了Jack。后来Jack正式向Benny展开猛烈追求，两人便热" ,@"commentPics" :@[] , @"commentReplys":@[@"影片讲述了1957年秋天",@"你好",@"什么鬼东西",@"微信网页版怎么看朋友圈,微信朋友圈类似一个个人心情分享平台,您可以在微信朋友圈查看好友的朋友圈动态。但是,很多人想实现在网页上查看微信朋",@"Benny与Eve决定离开居住已久的小镇"]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111102438134.jpg" , @"userName":@"王五" ,@"timeStamp":@"两天以前", @"commentText":@"微信朋友圈如何发布那些点进去有全文的信息_百度知道" ,@"commentPics" :@[] , @"commentReplys":@[@"信网页版怎么看朋友圈,微信朋友圈类似一个个人心情分享平台,您可以在微信朋友圈查看好友的朋友圈动态。但是,很多人想实现在网页上查看微信朋友圈的功能,",@"你好",@"什么鬼东西",@"微信网页版怎么看朋友圈,微信朋友圈类似一个个人心情分享平台,您可以在微信朋友圈查看好友的朋友圈动态。但是,很多人想实现在网页上查看微信朋",@"Benny与Eve决定离开居住已久的小镇"]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111135549273.jpg" , @"userName":@"赵六" ,@"timeStamp":@"三天以前", @"commentText":@" 微信网页版怎么看朋友圈,微信朋友圈类似一个个人心情分享平台,您可以在微信朋友圈查看好友的朋友圈动态。但是,很多人想实现在网页上查看微信朋友圈的功能,如今小编" ,@"commentPics" :@[] , @"commentReplys":@[@"6666666" , @"屌", @"6666666" , @"屌"]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111111123827.jpg" , @"userName":@"钱七" ,@"timeStamp":@"四天以前", @"commentText":@"从心灵鸡汤到过度营销一个段子是这样写的——同志们，现在走过来的是微信方阵，看他们左手手机，右手充电器；身后背着一锅心灵鸡汤，胸前挂着佛经和养生秘方，自吟着励志经典和情感小句；他们倾身侧脸嘟嘴瞪眼，45度俯拍着健步走过主席台。首长问：“同志们好，同志们刷新朋友圈了吗？ ”微信方阵响亮地回答：“首长好，天安门wifi密码是多少？”微信朋友圈已经从当初的心灵鸡汤，到后来的佛经和养生，再到一直存在且愈演愈烈的励志经典和情感段子，而且多个人还TM发的都一样，微信朋友圈就被这样多次、重复的刷屏。朋友圈的演变还远远没有结束，最近半年来，身材不好脸蛋还行的妹纸开始卖泰国蜗牛美肤品卖水母化妆品，身材和脸蛋都可以的开始自己当衣架子卖衣服和首饰，男人们也开始各种活动各种产品各种培训班的分享……整个朋友圈开始营销了，而且是过度营销了。微信出现以后，迅猛发展到今天，到底发生了什么？微信用户超过6亿，据微信团队匿名人员介绍，日活跃用户达到3亿。这明显影响到了新浪微博乃至腾讯自家的微博和QQ空间等产品，一个真实用户的精力是有限的，厚此薄彼。坊间一度传出新浪微博的用户活跃度下降40%，也有资料显示“截至2013年3月底，新浪微博注册用户数增长到5.36亿，比2012年底增加6.6%，微博日活跃用户数比2012年底增长7.8%，达到4980万”。" ,@"commentPics" :@[] , @"commentReplys":@[@"6666666" , @"屌"]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111120223224.jpg" , @"userName":@"张飞" ,@"timeStamp":@"五天以前", @"commentText":@"不管怎么样，现在的中国，微博上冷清不少" ,@"commentPics" :@[] , @"commentReplys":@[]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111102411836.jpg" , @"userName":@"关羽" ,@"timeStamp":@"六天以前", @"commentText":@"微博是一个全开放社交平台" ,@"commentPics" :@[] , @"commentReplys":@[]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111015327783.jpg" , @"userName":@"刘备" ,@"timeStamp":@"一周以前", @"commentText":@"但是，微信作为产品本身的设计正在被人为的打破，真的是人定胜天啊，朋友圈快看不下去，其中一个原因是用户自身造成的" ,@"commentPics" :@[] , @"commentReplys":@[]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111111123827.jpg" , @"userName":@"貂蝉" ,@"timeStamp":@"一月以前", @"commentText":@"但是" ,@"commentPics" :@[] , @"commentReplys":@[]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111102411836.jpg" , @"userName":@"吕布" ,@"timeStamp":@"半年以前", @"commentText":@"为产品本身的设计" ,@"commentPics" :@[] , @"commentReplys":@[]},
                                      @{@"avatar":@"http://touxiang.qqzhi.com/uploads/2012-11/1111012109240.jpg" , @"userName":@"曹操" ,@"timeStamp":@"一年以前", @"commentText":@"这明显影响到" ,@"commentPics" :@[] , @"commentReplys":@[]},]};
    
    NSString *responseCode = JSONDic[@"code"];
    if (JSONDic != nil && [responseCode isEqualToString:@"10000"]) {
        for (NSDictionary *dic in JSONDic[@"data"]) {
//            NSLog(@"dic == %@",dic);
            WLComment *comment = [[WLComment alloc] init];
            comment.avatar = dic[@"avatar"];
            comment.userName = dic[@"userName"];
            comment.timeStamp = dic[@"timeStamp"];
            comment.commentText = dic[@"commentText"];
            comment.commentReplys = dic[@"commentReplys"];
            comment.commentPics = dic[@"commentPics"];
            [self.dataSource addObject:comment];
        }
    }
//    NSLog(@"dataSource == %@",self.dataSource);
    [self performSelectorOnMainThread:@selector(refreshData) withObject:nil waitUntilDone:NO];
}
- (void)refreshData{
    [self.tableView reloadData];
}
#pragma mark - 数据源方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLComment *comment = self.dataSource[section];

    NSArray *replys = comment.commentReplys;
   
    return replys.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLComment *comment = self.dataSource[indexPath.section];
    WLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.comment.numberOfLines = 0;
    cell.comment.text = comment.commentReplys[indexPath.row];
    
    return cell;
}
#pragma mark - 代理方法
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    WLHeaderView *headerView = (WLHeaderView *)[self tableView:self.tableView viewForHeaderInSection:section];
//    NSLog(@"height == %f",headerView.frame.size.height);
    return headerView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    WLComment *comment = self.dataSource[section];
    WLHeaderView *headerView = (WLHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (headerView == nil) {
        headerView = [[WLHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    headerView.tapBlock = ^(NSInteger index,NSArray *dataSource){
        NSLog(@"点击了%ld张图片",index);
    };
    [headerView setCommentModel:comment];
    return headerView;
}
@end

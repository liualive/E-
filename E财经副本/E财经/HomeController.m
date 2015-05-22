//
//  HomeController.m
//  Scroll
//
//  Created by lanou3g on 15/5/21.
//  Copyright (c) 2015年 刘学丽. All rights reserved.
//

#import "HomeController.h"
#import "ContentCell.h"
#import "ContentController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"E财经新闻";

//设置左按钮
    self.navigationItem.leftBarButtonItem = [self addBtnImage:@"leibiao.ico" size:CGSizeMake(25, 25)];
    
//设置右按钮
    self.navigationItem.rightBarButtonItem = [self addBtnImage:@"抽屉右ios-head" size:CGSizeMake(30, 30)];
    
//设置Menu
    NSArray *items=[NSArray arrayWithObjects:@"头条",@"直播",@"黄金",@"外汇",@"理财", nil];
    UISegmentedControl *segMenu=[[UISegmentedControl alloc]initWithItems:items];
    segMenu.frame=CGRectMake(0, 64, self.view.bounds.size.width, 36);
    segMenu.tintColor=[UIColor blackColor];
    
    self.segMenu=segMenu;
    [self.view addSubview:segMenu];
    segMenu.selectedSegmentIndex=0;
    self.view.backgroundColor=[UIColor whiteColor];
    
//设置滚动视图
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, segMenu.bounds.size.height+64, self.view.bounds.size.width, self.view.bounds.size.height-36)];
    scrollView.backgroundColor=[UIColor lightGrayColor];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    self.scrollView=scrollView;
    scrollView.delegate=self;
    [scrollView setContentSize:CGSizeMake(5*CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds))];
    
//在ScrollView上添加tableViewcontroller
    for (int i = 0; i < 5; i++) {
    ContentController *tab=[[ContentController alloc]init];
    tab.view.frame=CGRectMake(i * CGRectGetWidth(scrollView.bounds), 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds));
        tab.view.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:tab.view];
    [tab release];
    }
    [segMenu addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:scrollView];
    [scrollView release];
    [segMenu release];
    
    
}

- (UIBarButtonItem *)addBtnImage:(NSString *)image size:(CGSize)size
{
    UIImage *img=[UIImage imageNamed:image];
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:img forState:UIControlStateNormal];
    CGSize btnSize = size;
    CGRect frame = btn.frame;
    frame.size = btnSize;
    btn.frame = frame;
    UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return [itemBtn autorelease];
}


//滑动ScrollView时候，菜单按钮随之改变
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint point=self.scrollView.contentOffset;
    if (self.segMenu.selectedSegmentIndex > point.x/self.scrollView.bounds.size.width) {
        self.segMenu.selectedSegmentIndex = point.x/self.scrollView.bounds.size.width;
    }else{
        self.segMenu.selectedSegmentIndex=point.x/self.scrollView.bounds.size.width+1;
        
    }
    
}
//点击菜单按钮时候，ScrollView随之改变
-(void)change:(UISegmentedControl *)seg
{
    NSInteger index=seg.selectedSegmentIndex;
    [self.scrollView setContentOffset:CGPointMake(index*self.scrollView.bounds.size.width, 0) animated:YES];
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{
    [_scrollView release];
    [_segMenu release];
    
    
    [super dealloc];
    
}
@end

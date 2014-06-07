//
//  RootViewController.m
//  CXTablePullRefreshDemo
//
//  Created by jessie on 14-6-4.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tablePullRefresh = [[CXTablePullRefresh alloc] init];
//    _tablePullRefresh = [[CXTablePullRefresh alloc] initWithUpArrow:[UIImage imageNamed:@"blackArrow.png"]];

    
    [self.view addSubview:_tablePullRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UISCrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tablePullRefresh CXViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_tablePullRefresh CXViewDidEndDragging:scrollView];
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
    //loading data.....
    //[self.tableView reloadData];
}


 -(void) doneLoadingTableViewData
{
   // NSLog(@"doneLoadingTableViewData");
    [_tablePullRefresh CXLoadDataFinish:self.tableView];
}

@end

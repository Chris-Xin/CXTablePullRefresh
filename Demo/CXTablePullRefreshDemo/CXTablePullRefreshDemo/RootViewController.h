//
//  RootViewController.h
//  CXTablePullRefreshDemo
//
//  Created by jessie on 14-6-4.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTablePullRefresh.h"

@interface RootViewController : UITableViewController <UIScrollViewDelegate>
{
    CXTablePullRefresh *_tablePullRefresh;
}
@end

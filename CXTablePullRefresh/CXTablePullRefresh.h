//
//  CXTablePullRefresh.h
//  CXTablePullRefreshDemo
//
//  Created by jessie on 14-6-4.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHE   [UIScreen mainScreen].bounds.size.height

typedef enum{
    CXRefreshNormal = 0,
	CXRefreshPulling,
	CXRefreshStopPulling,
	CXRefreshLoading,
} EGOPullRefreshState;

@interface CXTablePullRefresh : UIView
{
    EGOPullRefreshState _states;
    CXTablePullRefresh *delegate;
    
    UIView *_pullDownView;
    UIView *_stopPullView;
    UIView *_refreshView;
    
    UIActivityIndicatorView *_activityIndicatorView;
}

- (void)CXViewDidScroll:(UIScrollView *)scrollView;
- (void)CXViewDidEndDragging:(UIScrollView *)scrollView;
- (void)CXLoadDataFinish:(UIScrollView *)scrollView;

@end


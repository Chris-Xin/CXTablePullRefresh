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
} CXPullRefreshState;

typedef enum{
    CXRefreshStyleGray = 0,//default style
	CXRefreshStyleBlack,
	CXRefreshStyleBlue,
} CXPullRefreshStyle;

@interface CXTablePullRefresh : UIView
{
    CXPullRefreshState _states;
    CXTablePullRefresh *delegate;
    
    UIView *_pullDownView;
    UIView *_stopPullView;
    UIView *_refreshView;
    
    UIActivityIndicatorView *_activityIndicatorView;
}

- (id)initWithStyle:(CXPullRefreshStyle)style;
- (id)initWithUpArrow:(UIImage *)image;

//set Text Font&Color
- (void)setNoticeFont:(UIFont *)font;
- (void)setTimeFont:(UIFont *)font;
- (void)setNoticeColor:(UIColor *)color;
- (void)setTimeColor:(UIColor *)color;

//set notice text
- (void)setPullNoticeText:(NSString *)text;
- (void)setReleaseNoticeText:(NSString *)text;
- (void)setRefreshNoticeText:(NSString *)text;

//show refresh
- (void)CXViewDidScroll:(UIScrollView *)scrollView;
- (void)CXViewDidEndDragging:(UIScrollView *)scrollView;
- (void)CXLoadDataFinish:(UIScrollView *)scrollView;

@end


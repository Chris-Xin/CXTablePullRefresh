//
//  CXTablePullRefresh.m
//  CXTablePullRefreshDemo
//
//  Created by jessie on 14-6-4.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import "CXTablePullRefresh.h"

@implementation CXTablePullRefresh

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor grayColor];
        
        _states = CXRefreshNormal;
        
        //Pull Down View
        _pullDownView = [[UIView alloc] initWithFrame:frame];
        _pullDownView.backgroundColor = [UIColor clearColor];
        UIImageView *pullImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayArrow"]];
        pullImageView.frame = CGRectMake(120, frame.size.height - 30, 15, 30);
        [_pullDownView addSubview:pullImageView];
        
        UILabel *pullLable = [[UILabel alloc] init];
        pullLable.text = @"pull down to refresh!";
        pullLable.font = [UIFont systemFontOfSize:12.0f];
        pullLable.textColor = [UIColor blackColor];
        pullLable.frame = CGRectMake(150, frame.size.height - 20, 0, 0);
        [pullLable sizeToFit];
        [_pullDownView addSubview:pullLable];
        
        //Stop Pull Down View
        _stopPullView = [[UIView alloc] initWithFrame:frame];
        _stopPullView.backgroundColor = [UIColor clearColor];
        UIImageView *stopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayArrow"]];
        stopImageView.frame = CGRectMake(120, frame.size.height - 30, 15, 30);
        stopImageView.transform = CGAffineTransformRotate(stopImageView.transform, M_PI);
        [_stopPullView addSubview:stopImageView];
        
        UILabel *stopLable = [[UILabel alloc] init];
        stopLable.text = @"release to refresh!";
        stopLable.font = [UIFont systemFontOfSize:12.0f];
        stopLable.textColor = [UIColor blackColor];
        stopLable.frame = CGRectMake(150, frame.size.height - 20, 0, 0);
        [stopLable sizeToFit];
        [_stopPullView addSubview:stopLable];
        
        //Refresh View
        _refreshView = [[UIView alloc] initWithFrame:frame];
        _refreshView.backgroundColor = [UIColor clearColor];
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicatorView.frame = CGRectMake(120, frame.size.height - 30, 20.0f, 20.0f);
        [_refreshView addSubview:_activityIndicatorView];
        
        UILabel *refreshLable = [[UILabel alloc] init];
        refreshLable.text = @"Refresh...";
        refreshLable.font = [UIFont systemFontOfSize:12.0f];
        refreshLable.textColor = [UIColor blackColor];
        refreshLable.frame = CGRectMake(150, frame.size.height - 25, 0, 0);
        [refreshLable sizeToFit];
        [_refreshView addSubview:refreshLable];
        
        
    }
    return  self;
}

#pragma mark - Dragging
- (void)CXViewDidScroll:(UIScrollView *)scrollView
{
    float height = scrollView.contentOffset.y;
    //NSLog(@"height %f", height);
    if(height <= -20 && height >= -60  && _states != CXRefreshPulling && _states != CXRefreshLoading){
        _states = CXRefreshPulling;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [_stopPullView removeFromSuperview];
        [_refreshView removeFromSuperview];
        [self addSubview:_pullDownView];
        [UIView commitAnimations];
    }else if(height < -60 && _states != CXRefreshStopPulling && _states != CXRefreshLoading){
        _states = CXRefreshStopPulling;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [_pullDownView removeFromSuperview];
        [_refreshView removeFromSuperview];
        [self addSubview:_stopPullView];
        [UIView commitAnimations];
    }
}
- (void)CXViewDidEndDragging:(UIScrollView *)scrollView
{
    scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    
    //NSLog(@"CXViewDidEndDragging");
    _states = CXRefreshLoading;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_pullDownView removeFromSuperview];
    [_stopPullView removeFromSuperview];
    [self addSubview:_refreshView];
    [UIView commitAnimations];
    
    [_activityIndicatorView startAnimating];
    
}

#pragma mark - loadData Finish
- (void)CXLoadDataFinish:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_refreshView removeFromSuperview];
    [UIView commitAnimations];
    
    [_activityIndicatorView stopAnimating];
}

@end

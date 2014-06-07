//
//  CXTablePullRefresh.m
//  CXTablePullRefreshDemo
//
//  Created by jessie on 14-6-4.
//  Copyright (c) 2014年 Chris.Xin. All rights reserved.
//

#import "CXTablePullRefresh.h"

@implementation CXTablePullRefresh

- (id)init
{
    self = [self initWithStyle:CXRefreshStyleGray];
    
    return self;
}


- (id)initWithUpArrow:(UIImage *)image
{
    self = [self init];
    
    UIImageView *pullImageView = (UIImageView *)[_pullDownView viewWithTag:1];
    pullImageView.image = image;
    
    UIImageView *stopImageView =(UIImageView *)[_stopPullView viewWithTag:1];
    stopImageView.image = image;

    return self;
}

- (id)initWithStyle:(CXPullRefreshStyle)style
{
    self = [super init];
    
    if (self != nil) {
        self.frame = CGRectMake(0, 0-SCREEN_HEIGHE, 320, SCREEN_HEIGHE);
        self.backgroundColor = [UIColor grayColor];
        
        _states = CXRefreshNormal;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //Pull Down View
        _pullDownView = [[UIView alloc] init];
        
        NSString *imageName = nil;
        if(style == CXRefreshStyleBlue){
            imageName = @"blueArrow.png";
        }else if(style == CXRefreshStyleBlack){
            imageName = @"blackArrow.png";
        }else{
            imageName = @"grayArrow.png";
        }
        
        UIImageView *pullImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        pullImageView.frame = CGRectMake(120, SCREEN_HEIGHE-50, 15, 30);
        pullImageView.tag = 1;
        [_pullDownView addSubview:pullImageView];
        
        UILabel *pullLable = [[UILabel alloc] init];
        pullLable.text = @"pull down to refresh!";
        pullLable.font = [UIFont systemFontOfSize:12.0f];
        pullLable.textColor = [UIColor whiteColor];
        pullLable.backgroundColor = [UIColor clearColor];
        pullLable.frame = CGRectMake(150, SCREEN_HEIGHE-40, 0, 0);
        [pullLable sizeToFit];
        pullLable.tag = 2;
        [_pullDownView addSubview:pullLable];
        
        //Stop Pull Down View
        _stopPullView = [[UIView alloc] init];
        
        UIImageView *stopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        stopImageView.frame = CGRectMake(120, SCREEN_HEIGHE-50, 15, 30);
        stopImageView.tag = 1;
        stopImageView.transform = CGAffineTransformRotate(stopImageView.transform, M_PI);
        [_stopPullView addSubview:stopImageView];
        
        UILabel *stopLable = [[UILabel alloc] init];
        stopLable.text = @"release to refresh!";
        stopLable.font = [UIFont systemFontOfSize:12.0f];
        stopLable.textColor = [UIColor whiteColor];
        stopLable.backgroundColor = [UIColor clearColor];
        stopLable.frame = CGRectMake(150, SCREEN_HEIGHE-40, 0, 0);
        [stopLable sizeToFit];
        stopLable.tag = 2;
        [_stopPullView addSubview:stopLable];
        
        //Refresh View
        _refreshView = [[UIView alloc] init];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.tag = 1;
		_activityIndicatorView.frame = CGRectMake(120,  SCREEN_HEIGHE-50, 20.0f, 20.0f);
        [_refreshView addSubview:_activityIndicatorView];
        
        UILabel *refreshLable = [[UILabel alloc] init];
        refreshLable.text = @"Refresh...";
        refreshLable.font = [UIFont systemFontOfSize:12.0f];
        refreshLable.textColor = [UIColor whiteColor];
        refreshLable.backgroundColor = [UIColor clearColor];
        refreshLable.frame = CGRectMake(160, SCREEN_HEIGHE-50, 0, 0);
        [refreshLable sizeToFit];
        refreshLable.tag = 2;
        [_refreshView addSubview:refreshLable];
        
        UILabel *refreshTime = [[UILabel alloc]init];
        refreshTime.text = @"2014-06-06 16:55";
        refreshTime.font = [UIFont systemFontOfSize:10.0f];
        refreshTime.textColor = [UIColor whiteColor];
        refreshTime.backgroundColor = [UIColor clearColor];
        refreshTime.frame = CGRectMake(160, refreshLable.frame.origin.y+refreshLable.frame.size.height+8, 0, 0);
        [refreshTime sizeToFit];
        refreshTime.tag = 3;
        [_refreshView addSubview:refreshTime];
        
        
        
    }
    return  self;
}

#pragma mark - Set Text Font&Color
- (void)setNoticeFont:(UIFont *)font
{
    UILabel *pullLable = (UILabel *)[_pullDownView viewWithTag:2];
    pullLable.font = font;
    [pullLable sizeToFit];
    
    UILabel *stopLable = (UILabel *)[_stopPullView viewWithTag:2];
    stopLable.font = font;
    [pullLable sizeToFit];
    
    UILabel *refreshLable = (UILabel *)[_refreshView viewWithTag:2];
    refreshLable.font = font;
    [refreshLable sizeToFit];
}

- (void)setTimeFont:(UIFont *)font
{
    UILabel *refreshTime  = (UILabel *)[_refreshView viewWithTag:3];
    refreshTime.font = font;
    [refreshTime sizeToFit];
}

- (void)setNoticeColor:(UIColor *)color
{
    UILabel *pullLable = (UILabel *)[_pullDownView viewWithTag:2];
    pullLable.textColor = color;
    
    UILabel *stopLable = (UILabel *)[_stopPullView viewWithTag:2];
    stopLable.textColor = color;
    
    UILabel *refreshLable = (UILabel *)[_refreshView viewWithTag:2];
    refreshLable.textColor = color;
}

- (void)setTimeColor:(UIColor *)color
{
    UILabel *refreshTime  = (UILabel *)[_refreshView viewWithTag:3];
    refreshTime.textColor = color;
}

#pragma mark - Set Notice Text
- (void)setPullNoticeText:(NSString *)text
{
    UILabel *pullLable = (UILabel *)[_pullDownView viewWithTag:2];
    pullLable.text = text;
}

- (void)setReleaseNoticeText:(NSString *)text
{
    UILabel *stopLable = (UILabel *)[_stopPullView viewWithTag:2];
    stopLable.text = text;
}

- (void)setRefreshNoticeText:(NSString *)text
{
    UILabel *refreshLable = (UILabel *)[_refreshView viewWithTag:2];
    refreshLable.text = text;
}


#pragma mark - Show Refresh
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
    NSDateFormatter *formt = [[NSDateFormatter alloc] init];
    [formt setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    NSString *dateString = [formt stringFromDate:date];
    NSLog(@"%@", dateString);
    
    UILabel *refreshTime = [_refreshView viewWithTag:3];
    refreshTime.text = dateString;
    [refreshTime sizeToFit];
    
    _states = CXRefreshLoading;
    
    scrollView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_pullDownView removeFromSuperview];
    [_stopPullView removeFromSuperview];
    [self addSubview:_refreshView];
    [UIView commitAnimations];
    
    [_activityIndicatorView startAnimating];
    
}

- (void)CXLoadDataFinish:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_refreshView removeFromSuperview];
    [UIView commitAnimations];
    
    [_activityIndicatorView stopAnimating];
    
    _states = CXRefreshNormal;
}

@end

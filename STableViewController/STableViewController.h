//
//  STableViewController.h
//  STableViewController
//
//  Created by Shiki on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface STableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

@protected
  
  BOOL isDragging;
  BOOL isRefreshing;
  
  // had to store this because the headerView's frame seems to be changed somewhere during scrolling
  // and I couldn't figure out why >.<
  CGRect headerViewFrame;
}

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UITableView *tableView;

// The minimum height that the user should drag down in order to trigger a "refresh" when
// dragging ends. 
- (CGFloat) headerRefreshHeight;

// Will be called if the user drags down which will show the header view. Override this to
// update the header view (e.g. change the label to "Pull down to refresh").
- (void) willShowHeaderView:(UIScrollView *)scrollView;

// If the user is dragging, will be called on every scroll event that the headerView is shown. 
// The value of willRefreshOnRelease will be YES if the user scrolled down enough to trigger a 
// "refresh" when the user releases the drag.
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView;

// By default, will permanently show the headerView by setting the tableView's contentInset.
- (void) pinHeaderView;

// Reverse of pinHeaderView. 
- (void) unpinHeaderView;

// Called when the user stops dragging and, if the conditions are met, will trigger a refresh.
- (void) willBeginRefresh;

// Override to perform fetching of data.
- (void) refresh;

// Call to signal that refresh has completed. This will then hide the headerView.
- (void) refreshCompleted;

@end

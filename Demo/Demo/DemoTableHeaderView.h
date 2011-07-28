//
//  DemoTableHeaderView.h
//  STableViewController
//
//  Created by Shiki on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DemoTableHeaderView : UIView {
    
  UILabel *title;
  UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

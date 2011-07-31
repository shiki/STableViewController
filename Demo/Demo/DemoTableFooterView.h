//
//  DemoTableFooterView.h
//  Demo
//
//  Created by Shiki on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DemoTableFooterView : UIView {
    
  UIActivityIndicatorView *activityIndicator;
  UILabel *infoLabel;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel *infoLabel;

@end

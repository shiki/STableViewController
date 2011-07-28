//
//  DemoTableHeaderView.m
//  STableViewController
//
//  Created by Shiki on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoTableHeaderView.h"


@implementation DemoTableHeaderView
@synthesize title;
@synthesize activityIndicator;


- (void)dealloc
{
  [title release];
  [activityIndicator release];
  [super dealloc];
}

@end

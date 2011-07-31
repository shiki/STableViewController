//
//  DemoTableFooterView.m
//  Demo
//
//  Created by Shiki on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoTableFooterView.h"


@implementation DemoTableFooterView

@synthesize activityIndicator;
@synthesize infoLabel;

- (void)dealloc
{
  [activityIndicator release];
  [infoLabel release];
  [super dealloc];
}

@end

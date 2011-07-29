
#import "DemoTableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableViewController


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addSampleItem
{
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
  [items insertObject:[dateFormatter stringFromDate:[NSDate date]] atIndex:0];
  
  [self.tableView reloadData];
  
  // call this so the header will be hidden
  [self refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  // set the custom view for "pull to refresh"
  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
  DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
  self.headerView = headerView;
  
  // set the custom view for "load more"
  nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
  DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
  self.footerView = footerView;
  
  // add sample items
  items = [[NSMutableArray alloc] init];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem];
  [self addSampleItem]; // lazy :p (will refactor later)
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return items.count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.text = [items objectAtIndex:indexPath.row];  
  return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
  [super pinHeaderView];
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  [hv.activityIndicator startAnimating];
  hv.title.text = @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
  [super unpinHeaderView];
  [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  if (willRefreshOnRelease)
    hv.title.text = @"Release to refresh...";
  else
    hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) refresh
{
  // do your async calls here
  [self performSelector:@selector(addSampleItem) withObject:nil afterDelay:2.0];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) willBeginLoadingMore
{
  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadMoreCompleted:(BOOL)noMoreItemsToLoadValue
{
  [super loadMoreCompleted:noMoreItemsToLoadValue];
  
  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator stopAnimating];
  
  if (noMoreItemsToLoadValue) {
    // do something if there are no more items to load
    self.footerView = nil;    
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) completeLoadMore
{
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
  NSString *date = [dateFormatter stringFromDate:[NSDate date]];
  [items addObject:date];
  [items addObject:[date copy]];
  [items addObject:[date copy]];
  [items addObject:[date copy]];
  [items addObject:[date copy]];
  
  [self.tableView reloadData];
  
  if (items.count > 30)
    [self loadMoreCompleted:YES]; // signal that there won't be any more items to load
  else
    [self loadMoreCompleted:NO];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
  if (![super loadMore])
    return NO;
  
  [self performSelector:@selector(completeLoadMore) withObject:nil afterDelay:2.0];
  
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [super dealloc];
}

@end

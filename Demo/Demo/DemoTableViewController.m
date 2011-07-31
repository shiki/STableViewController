
#import "DemoTableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
// Helper
- (NSString *) createRandomValue
{
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
  
  return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
          [NSNumber numberWithInt:rand()]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  // set the custom view for "pull to refresh". See DemoTableHeaderView.xib.
  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
  DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
  self.headerView = headerView;
  
  // set the custom view for "load more". See DemoTableFooterView.xib.
  nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
  DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
  self.footerView = footerView;
  
  // add sample items
  items = [[NSMutableArray alloc] init];
  for (int i = 0; i < 10; i++)
    [items addObject:[self createRandomValue]];
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
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
  [super pinHeaderView];
  
  // do custom handling for the header view
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  [hv.activityIndicator startAnimating];
  hv.title.text = @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
  [super unpinHeaderView];
  
  // do custom handling for the header view
  [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  if (willRefreshOnRelease)
    hv.title.text = @"Release to refresh...";
  else
    hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
  for (int i = 0; i < 3; i++)
    [items insertObject:[self createRandomValue] atIndex:0];
  [self.tableView reloadData];
  
  // Call this to indicate that we have finished "refreshing".
  // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
  [self refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (BOOL) refresh
{
  if (![super refresh])
    return NO;
  
  [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more). 
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void)loadMoreCompleted
{
  [super loadMoreCompleted];

  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator stopAnimating];
  
  if (!self.canLoadMore) {
    // Do something if there are no more items to load
    
    // We can remove the footerView by: self.footerView = nil;    
    
    // Just show a textual info that there are no more items to load
    fv.infoLabel.hidden = NO;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
  for (int i = 0; i < 5; i++)
    [items addObject:[self createRandomValue]];  
  
  [self.tableView reloadData];
  
  if (items.count > 50)
    self.canLoadMore = NO; // signal that there won't be any more items to load
  else
    self.canLoadMore = YES;
  
  [self loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
  if (![super loadMore])
    return NO;
  
  [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
  
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [super dealloc];
}

@end

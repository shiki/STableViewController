
#import "DemoViewController.h"
#import "DemoTableHeaderView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoViewController


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
  DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
  self.headerView = headerView;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 10;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.text = @"Sample";
  
  // Configure the cell.
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
- (void)headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  if (willRefreshOnRelease)
    hv.title.text = @"Release to refresh...";
  else
    hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [super dealloc];
}

@end

Pod::Spec.new do |s|
  s.name    = 'STableViewController'
  s.version = '0.0.2'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'http://github.com/shiki/STableViewController'
  s.summary = 'A custom UIViewController with a UITableView which supports "pull to refresh" and "load more"'
  s.author = {
    'Shiki' => 'jayson@basanes.net'
  }
  s.source = {
    :git => 'https://github.com/shiki/STableViewController.git',
    :tag => s.version.to_s
  }
  s.platform = :ios, "7.1"
  s.source_files = 'STableViewController/*.{h,m}'
  s.requires_arc = false
end

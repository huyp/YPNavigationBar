Pod::Spec.new do |s|
  s.name         = 'YPNavigationBar'
  s.version      = '0.1'
  s.summary      = 'Independent navigation'
  s.homepage     = 'https://github.com/huyp/YPNavigationBar'
  s.license      = 'MIT'
  s.authors      = {'HYP' => '406468133@qq.com'}
  s.platform     = :ios, '9.0'
  s.source       = {:git => 'https://github.com/huyp/YPNavigationBar.git', :tag => s.version}
  s.source_files = 'YPNavigationBar/*.{h,m}'
  s.resource     = 'YPNavigationBar/YPNavigationBar.bundle'
end
Pod::Spec.new do |s|
  s.name         = 'YPNavigationBar'
  s.version      = '0.1.3'
  s.summary      = 'Independent navigation'
  s.homepage     = 'https://github.com/huyp/YPNavigationBar'
  s.license      = 'MIT'
  s.authors      = {'HYP' => 'huyanpengvip@126.com'}
  s.platform     = :ios, '9.0'
  s.source       = {:git => 'https://github.com/huyp/YPNavigationBar.git', :tag => s.version}
  s.source_files = 'YPNavigationBar/**/*.{h,m}'
  s.public_header_files = 'YPNavigationBar/**/*.{h}'
  s.resource     = 'YPNavigationBar/YPNavigationBar.bundle'

end

platform :ios, '9.0'

target 'Necktie' do
  use_frameworks!

  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireObjectMapper', '~> 4.0'
  pod 'ARSLineProgress', '~> 2.1'
  pod 'BusyNavigationBar', '~> 2.0'
  pod 'DGElasticPullToRefresh', '~> 1.1'
  pod 'DZNEmptyDataSet', '~> 1.8'
  pod 'IHKeyboardAvoiding', '~> 2.6'
  pod 'KDCircularProgress'
  pod 'Locksmith', '~> 3.0'
  pod 'RevealingSplashView', '~> 0.1'
  pod 'ScrollableGraphView', '~> 3.0'
  pod 'Segmentio', '~> 2.0'
  pod 'SideMenuController', '~> 0.2'
  pod 'SkyFloatingLabelTextField', git: 'https://github.com/MLSDev/SkyFloatingLabelTextField.git', branch: 'swift3'
  pod 'SnapKit', '~> 3.0'
  pod 'SwiftChart', '~> 0.3'
  pod 'SwiftyUserDefaults', '~> 3.0'
  pod 'UICircularProgressRing', '~> 1.1'

  target 'NecktieTests' do
    inherit! :search_paths
  end

  target 'NecktieUITests' do
    inherit! :search_paths
  end
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end

end

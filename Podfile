# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

inhibit_all_warnings!

use_frameworks!

# connectivity
def connectivity
  pod 'Alamofire', '~> 4.5'
  pod 'AlamofireImage', '~> 3'
end

# data
def data_manager
  pod 'SwiftyJSON', '~> 3.1.3'
end

target 'UsersMasterDetail' do
  connectivity
  data_manager
  
  target 'UsersMasterDetailTests' do
      inherit! :search_paths
      # Pods for testing
  end
  
  target 'UsersMasterDetailUITests' do
      inherit! :complete
      # Pods for testing
  end
end




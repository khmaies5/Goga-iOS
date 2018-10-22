source 'https://github.com/CocoaPods/Specs.git’
platform :ios, '10.0’
use_frameworks!
target 'Goga1' do
    pod 'Alamofire', '~> 4.0’
    pod 'Koloda', '~> 4.3.1'
    pod 'paper-onboarding', '~> 2.1'
    pod 'SwiftyJSON'
    pod 'ObjectMapper', '~> 2.2'
    pod 'TextFieldEffects'
    pod 'SVProgressHUD'
    pod 'PopupDialog', '~> 0.5.4'
    pod 'SwiftGifOrigin', '~> 1.6.1'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    pod 'LFTwitterProfile'
end

post_install do |installer|
    `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end

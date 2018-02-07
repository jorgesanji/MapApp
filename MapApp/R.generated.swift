//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `test_tracking.gpx`.
    static let test_trackingGpx = Rswift.FileResource(bundle: R.hostingBundle, name: "test_tracking", pathExtension: "gpx")
    
    /// `bundle.url(forResource: "test_tracking", withExtension: "gpx")`
    static func test_trackingGpx(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.test_trackingGpx
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 4 nibs.
  struct nib {
    /// Nib `HomeView`.
    static let homeView = _R.nib._HomeView()
    /// Nib `MapTrackingView`.
    static let mapTrackingView = _R.nib._MapTrackingView()
    /// Nib `SplashView`.
    static let splashView = _R.nib._SplashView()
    /// Nib `TrackCellView`.
    static let trackCellView = _R.nib._TrackCellView()
    
    /// `UINib(name: "HomeView", in: bundle)`
    static func homeView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.homeView)
    }
    
    /// `UINib(name: "MapTrackingView", in: bundle)`
    static func mapTrackingView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.mapTrackingView)
    }
    
    /// `UINib(name: "SplashView", in: bundle)`
    static func splashView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.splashView)
    }
    
    /// `UINib(name: "TrackCellView", in: bundle)`
    static func trackCellView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.trackCellView)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `DiStoryboard`.
    static let diStoryboard = _R.storyboard.diStoryboard()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "DiStoryboard", bundle: ...)`
    static func diStoryboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.diStoryboard)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.infoPlist` struct is generated, and contains static references to 2 localization keys.
    struct infoPlist {
      /// en translation: Location used for trancking
      /// 
      /// Locales: en, es
      static let nsLocationWhenInUseUsageDescription = Rswift.StringResource(key: "NSLocationWhenInUseUsageDescription", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Motion used for activate o deactivate tracking
      /// 
      /// Locales: en, es
      static let nsMotionUsageDescription = Rswift.StringResource(key: "NSMotionUsageDescription", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      
      /// en translation: Location used for trancking
      /// 
      /// Locales: en, es
      static func nsLocationWhenInUseUsageDescription(_: Void = ()) -> String {
        return NSLocalizedString("NSLocationWhenInUseUsageDescription", tableName: "InfoPlist", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Motion used for activate o deactivate tracking
      /// 
      /// Locales: en, es
      static func nsMotionUsageDescription(_: Void = ()) -> String {
        return NSLocalizedString("NSMotionUsageDescription", tableName: "InfoPlist", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.localizable` struct is generated, and contains static references to 16 localization keys.
    struct localizable {
      /// Base translation: Accept
      /// 
      /// Locales: en, Base, es
      static let ok_action = Rswift.StringResource(key: "ok_action", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Cancel
      /// 
      /// Locales: en, Base, es
      static let cancel_action = Rswift.StringResource(key: "cancel_action", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Do you want to cancel the path tracking?
      /// 
      /// Locales: en, Base, es
      static let message_cancel_tracking = Rswift.StringResource(key: "message_cancel_tracking", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Do you want to save the path tracking?
      /// 
      /// Locales: en, Base, es
      static let message_stop_tracking = Rswift.StringResource(key: "message_stop_tracking", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Emtpy list please create a route.
      /// 
      /// Locales: en, Base, es
      static let message_empty = Rswift.StringResource(key: "message_empty", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: End date: %@
      /// 
      /// Locales: en, Base, es
      static let end_date = Rswift.StringResource(key: "end_date", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: MapApp
      /// 
      /// Locales: en, Base, es
      static let app_name = Rswift.StringResource(key: "app_name", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: MapApp
      /// 
      /// Locales: en, Base, es
      static let title_stop_tracking = Rswift.StringResource(key: "title_stop_tracking", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Please go to settings and enable motion feature on your device.
      /// 
      /// Locales: en, Base, es
      static let message_motion_disabled = Rswift.StringResource(key: "message_motion_disabled", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: ROUTE %i
      /// 
      /// Locales: en, Base, es
      static let track_number = Rswift.StringResource(key: "track_number", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Recommend you move in order to track your route.
      /// 
      /// Locales: en, Base, es
      static let message_tracking_standing = Rswift.StringResource(key: "message_tracking_standing", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Start date: %@
      /// 
      /// Locales: en, Base, es
      static let start_date = Rswift.StringResource(key: "start_date", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Start tracking
      /// 
      /// Locales: en, Base, es
      static let start_tracking = Rswift.StringResource(key: "start_tracking", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Stop tracking
      /// 
      /// Locales: en, Base, es
      static let stop_tracking = Rswift.StringResource(key: "stop_tracking", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: Tracking
      /// 
      /// Locales: en, Base, es
      static let tracking_title = Rswift.StringResource(key: "tracking_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      /// Base translation: User already register on KeyChain
      /// 
      /// Locales: en, Base, es
      static let message_user_already_register = Rswift.StringResource(key: "message_user_already_register", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "Base", "es"], comment: nil)
      
      /// Base translation: Accept
      /// 
      /// Locales: en, Base, es
      static func ok_action(_: Void = ()) -> String {
        return NSLocalizedString("ok_action", bundle: R.hostingBundle, value: "Accept", comment: "")
      }
      
      /// Base translation: Cancel
      /// 
      /// Locales: en, Base, es
      static func cancel_action(_: Void = ()) -> String {
        return NSLocalizedString("cancel_action", bundle: R.hostingBundle, value: "Cancel", comment: "")
      }
      
      /// Base translation: Do you want to cancel the path tracking?
      /// 
      /// Locales: en, Base, es
      static func message_cancel_tracking(_: Void = ()) -> String {
        return NSLocalizedString("message_cancel_tracking", bundle: R.hostingBundle, value: "Do you want to cancel the path tracking?", comment: "")
      }
      
      /// Base translation: Do you want to save the path tracking?
      /// 
      /// Locales: en, Base, es
      static func message_stop_tracking(_: Void = ()) -> String {
        return NSLocalizedString("message_stop_tracking", bundle: R.hostingBundle, value: "Do you want to save the path tracking?", comment: "")
      }
      
      /// Base translation: Emtpy list please create a route.
      /// 
      /// Locales: en, Base, es
      static func message_empty(_: Void = ()) -> String {
        return NSLocalizedString("message_empty", bundle: R.hostingBundle, value: "Emtpy list please create a route.", comment: "")
      }
      
      /// Base translation: End date: %@
      /// 
      /// Locales: en, Base, es
      static func end_date(_ value1: String) -> String {
        return String(format: NSLocalizedString("end_date", bundle: R.hostingBundle, value: "End date: %@", comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Base translation: MapApp
      /// 
      /// Locales: en, Base, es
      static func app_name(_: Void = ()) -> String {
        return NSLocalizedString("app_name", bundle: R.hostingBundle, value: "MapApp", comment: "")
      }
      
      /// Base translation: MapApp
      /// 
      /// Locales: en, Base, es
      static func title_stop_tracking(_: Void = ()) -> String {
        return NSLocalizedString("title_stop_tracking", bundle: R.hostingBundle, value: "MapApp", comment: "")
      }
      
      /// Base translation: Please go to settings and enable motion feature on your device.
      /// 
      /// Locales: en, Base, es
      static func message_motion_disabled(_: Void = ()) -> String {
        return NSLocalizedString("message_motion_disabled", bundle: R.hostingBundle, value: "Please go to settings and enable motion feature on your device.", comment: "")
      }
      
      /// Base translation: ROUTE %i
      /// 
      /// Locales: en, Base, es
      static func track_number(_ value1: Int) -> String {
        return String(format: NSLocalizedString("track_number", bundle: R.hostingBundle, value: "ROUTE %i", comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Base translation: Recommend you move in order to track your route.
      /// 
      /// Locales: en, Base, es
      static func message_tracking_standing(_: Void = ()) -> String {
        return NSLocalizedString("message_tracking_standing", bundle: R.hostingBundle, value: "Recommend you move in order to track your route.", comment: "")
      }
      
      /// Base translation: Start date: %@
      /// 
      /// Locales: en, Base, es
      static func start_date(_ value1: String) -> String {
        return String(format: NSLocalizedString("start_date", bundle: R.hostingBundle, value: "Start date: %@", comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Base translation: Start tracking
      /// 
      /// Locales: en, Base, es
      static func start_tracking(_: Void = ()) -> String {
        return NSLocalizedString("start_tracking", bundle: R.hostingBundle, value: "Start tracking", comment: "")
      }
      
      /// Base translation: Stop tracking
      /// 
      /// Locales: en, Base, es
      static func stop_tracking(_: Void = ()) -> String {
        return NSLocalizedString("stop_tracking", bundle: R.hostingBundle, value: "Stop tracking", comment: "")
      }
      
      /// Base translation: Tracking
      /// 
      /// Locales: en, Base, es
      static func tracking_title(_: Void = ()) -> String {
        return NSLocalizedString("tracking_title", bundle: R.hostingBundle, value: "Tracking", comment: "")
      }
      
      /// Base translation: User already register on KeyChain
      /// 
      /// Locales: en, Base, es
      static func message_user_already_register(_: Void = ()) -> String {
        return NSLocalizedString("message_user_already_register", bundle: R.hostingBundle, value: "User already register on KeyChain", comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _HomeView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "HomeView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> HomeView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HomeView
      }
      
      fileprivate init() {}
    }
    
    struct _MapTrackingView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "MapTrackingView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> MapTrackingView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MapTrackingView
      }
      
      fileprivate init() {}
    }
    
    struct _SplashView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SplashView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> SplashView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SplashView
      }
      
      fileprivate init() {}
    }
    
    struct _TrackCellView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TrackCellView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> TrackCellView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TrackCellView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try diStoryboard.validate()
    }
    
    struct diStoryboard: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let mapTrackingViewController = StoryboardViewControllerResource<MapTrackingViewController>(identifier: "MapTrackingViewController")
      let name = "DiStoryboard"
      let splashViewController = StoryboardViewControllerResource<SplashViewController>(identifier: "SplashViewController")
      
      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }
      
      func mapTrackingViewController(_: Void = ()) -> MapTrackingViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mapTrackingViewController)
      }
      
      func splashViewController(_: Void = ()) -> SplashViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: splashViewController)
      }
      
      static func validate() throws {
        if _R.storyboard.diStoryboard().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'DiStoryboard' as 'HomeViewController'.") }
        if _R.storyboard.diStoryboard().mapTrackingViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mapTrackingViewController' could not be loaded from storyboard 'DiStoryboard' as 'MapTrackingViewController'.") }
        if _R.storyboard.diStoryboard().splashViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'splashViewController' could not be loaded from storyboard 'DiStoryboard' as 'SplashViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
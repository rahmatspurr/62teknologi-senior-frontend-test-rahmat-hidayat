//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 4 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `MainColor`.
    static let mainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "MainColor")
    /// Color `OrangeSoft`.
    static let orangeSoft = Rswift.ColorResource(bundle: R.hostingBundle, name: "OrangeSoft")
    /// Color `RedLight`.
    static let redLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "RedLight")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "MainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func mainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.mainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "OrangeSoft", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func orangeSoft(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.orangeSoft, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "RedLight", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func redLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.redLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "MainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func mainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.mainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "OrangeSoft", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func orangeSoft(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.orangeSoft.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "RedLight", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func redLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.redLight.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 8 images.
  struct image {
    /// Image `ic_place`.
    static let ic_place = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_place")
    /// Image `ic_rating`.
    static let ic_rating = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_rating")
    /// Image `ic_shop_banner_placeholder`.
    static let ic_shop_banner_placeholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_shop_banner_placeholder")
    /// Image `ic_shop_placeholder`.
    static let ic_shop_placeholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_shop_placeholder")
    /// Image `ic_shop`.
    static let ic_shop = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_shop")
    /// Image `ic_toast_error`.
    static let ic_toast_error = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_toast_error")
    /// Image `ic_toast_warning`.
    static let ic_toast_warning = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_toast_warning")
    /// Image `ic_user_placeholder`.
    static let ic_user_placeholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_user_placeholder")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_place", bundle: ..., traitCollection: ...)`
    static func ic_place(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_place, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_rating", bundle: ..., traitCollection: ...)`
    static func ic_rating(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_rating, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_shop", bundle: ..., traitCollection: ...)`
    static func ic_shop(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_shop, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_shop_banner_placeholder", bundle: ..., traitCollection: ...)`
    static func ic_shop_banner_placeholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_shop_banner_placeholder, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_shop_placeholder", bundle: ..., traitCollection: ...)`
    static func ic_shop_placeholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_shop_placeholder, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_toast_error", bundle: ..., traitCollection: ...)`
    static func ic_toast_error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_toast_error, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_toast_warning", bundle: ..., traitCollection: ...)`
    static func ic_toast_warning(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_toast_warning, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_user_placeholder", bundle: ..., traitCollection: ...)`
    static func ic_user_placeholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_user_placeholder, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 5 nibs.
  struct nib {
    /// Nib `BusinessTableViewCell`.
    static let businessTableViewCell = _R.nib._BusinessTableViewCell()
    /// Nib `DetailBusinessViewController`.
    static let detailBusinessViewController = _R.nib._DetailBusinessViewController()
    /// Nib `ListBusinessViewController`.
    static let listBusinessViewController = _R.nib._ListBusinessViewController()
    /// Nib `ReviewTableViewCell`.
    static let reviewTableViewCell = _R.nib._ReviewTableViewCell()
    /// Nib `SlideshowCollectionViewCell`.
    static let slideshowCollectionViewCell = _R.nib._SlideshowCollectionViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "BusinessTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.businessTableViewCell) instead")
    static func businessTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.businessTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DetailBusinessViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.detailBusinessViewController) instead")
    static func detailBusinessViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.detailBusinessViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "ListBusinessViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.listBusinessViewController) instead")
    static func listBusinessViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.listBusinessViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "ReviewTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.reviewTableViewCell) instead")
    static func reviewTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.reviewTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SlideshowCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.slideshowCollectionViewCell) instead")
    static func slideshowCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.slideshowCollectionViewCell)
    }
    #endif

    static func businessTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BusinessTableViewCell? {
      return R.nib.businessTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BusinessTableViewCell
    }

    static func detailBusinessViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.detailBusinessViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func listBusinessViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.listBusinessViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func reviewTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ReviewTableViewCell? {
      return R.nib.reviewTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ReviewTableViewCell
    }

    static func slideshowCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SlideshowCollectionViewCell? {
      return R.nib.slideshowCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SlideshowCollectionViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `BusinessTableViewCell`.
    static let businessTableViewCell: Rswift.ReuseIdentifier<BusinessTableViewCell> = Rswift.ReuseIdentifier(identifier: "BusinessTableViewCell")
    /// Reuse identifier `ReviewTableViewCell`.
    static let reviewTableViewCell: Rswift.ReuseIdentifier<ReviewTableViewCell> = Rswift.ReuseIdentifier(identifier: "ReviewTableViewCell")
    /// Reuse identifier `SlideshowCollectionViewCell`.
    static let slideshowCollectionViewCell: Rswift.ReuseIdentifier<SlideshowCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "SlideshowCollectionViewCell")

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
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _BusinessTableViewCell.validate()
      try _DetailBusinessViewController.validate()
      try _ReviewTableViewCell.validate()
    }

    struct _BusinessTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = BusinessTableViewCell

      let bundle = R.hostingBundle
      let identifier = "BusinessTableViewCell"
      let name = "BusinessTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BusinessTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BusinessTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_rating", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_rating' is used in nib 'BusinessTableViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_shop_placeholder", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_shop_placeholder' is used in nib 'BusinessTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _DetailBusinessViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "DetailBusinessViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_place", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_place' is used in nib 'DetailBusinessViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_rating", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_rating' is used in nib 'DetailBusinessViewController', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "AccentColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'AccentColor' is used in nib 'DetailBusinessViewController', but couldn't be loaded.") }
          if UIKit.UIColor(named: "RedLight", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'RedLight' is used in nib 'DetailBusinessViewController', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    struct _ListBusinessViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ListBusinessViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _ReviewTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = ReviewTableViewCell

      let bundle = R.hostingBundle
      let identifier = "ReviewTableViewCell"
      let name = "ReviewTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ReviewTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ReviewTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_rating", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_rating' is used in nib 'ReviewTableViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_shop_placeholder", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_shop_placeholder' is used in nib 'ReviewTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _SlideshowCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SlideshowCollectionViewCell

      let bundle = R.hostingBundle
      let identifier = "SlideshowCollectionViewCell"
      let name = "SlideshowCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SlideshowCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SlideshowCollectionViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "ic_shop", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_shop' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
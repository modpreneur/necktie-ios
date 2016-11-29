#Readme

##Getting the code

	git clone https://github.com/modpreneur/necktie-ios.git
	cd Necktie
	pod install

##Libraries / Cocoapods

- **Alamofire**
	- great library for all the networking stuff
- **SideMenuController**
	- side menu (for configuration see below)
- **SnapKit**
	- easy AutoLayout in code (Swift version of *Masonry*)
- **IHKeyboardAvoiding**
	- library to keep text fields (or other views) always above keyboard
- **KeychainAccess**
	- better way to work with system keychains and Touch ID
- **SwiftyUserDefaults**
	- better way to work with NSUserDefaults
- **Segmentio**
	- adds nice segmented control
- **ScrollableGraphView**
	- adds customizable line and bar graphs
- **SwiftChart**
	- charts
- **UICircularProgressRing**
	- adds animated circular progress view
- **KDCircularProgress**
	- adds animated circular progress view
- **SkyFloatingLabelTextField**
	- adds floating label to text fields
- **RevealingSplashView**
	- adds nice intro animation

##Side Menu

Menu is configured in `Menu.swift`. Each item is a *struct* called `MenuItem` with 3 properties:

- **name** (*String*): text displayed in menu
- **segue** (*String*): segue identifier leading to viewController
- **image** (*String*): image name for icon

These items are then added to `menuItems` array for further use.

As each menu item should have its own storyboard, the segue just leads to storyboard reference (available from iOS 8).

`MenuContainerViewController.swift` is just a wrapper which loads the menu using custom segues (see *SideMenuController* documentation<sup id="an1">[1](#fn1)</sup>).

`MenuViewController.swift` is the main class for menu. It is a *UITableVIewController* subclass which takes `menuItems` and displays them.

`MenuTableViewCell.swift` is a UITableViewCell for each menu item. It has two *IBOutlets*: `menuItemName` (*UILabel*) and `menuItemIcon` (*UIImageView*).

`SideMenuCustom.swift` provides side menu customization (animations, gestures etc.). See *SideMenuController* documentation<sup id="an1">[1](#fn1)</sup>.

View Controller to be presented from menu has to conform to SideMenuControllerDelegate (needs two methods: `sideMenuControllerDidHide(_sidemenuController:)` and `sideMenuControllerDidReveal(_sideMenuController:`). To add left menu button item just call `navigationController?.addSideMenuButton()` in *viewDidLoad*.

##Storyboards

Storyboards are separated to smaller ones for each menu item.

##Helpers

- **Constants.swift**: basic constants.
- **UIColor+Necktie.swift**: global colors extension (call `UIColor().customColor`)
- **NavigationController.swift**: sets default appearance for *UINavigationController* used in the app (font, gradient background).
- **TableView.swift**: *UITableView* subclass which sets rounded corners (header, footer) and separators. `@IBDesignable` if needed.
- **SearchBar.swift**: *UISearchBar* subclass which sets its font.
- **GradientView.swift**: creates `@IBDesignable` *UIView* to create gradient (vertical, horizontal or diagonal).

##Colors

Colors used in this project (as defined in `UIColor+Necktie.swift`):

- *necktiePrimary*: `UIColor(red:0.09, green:0.741, blue:1, alpha:1)`
- *necktieSecondary*: `UIColor(red:0.176, green:0.196, blue:0.243, alpha:1)`
- *necktieSecondaryLight*: `UIColor(red:0.156, green:0.172, blue:0.215, alpha:1)`
- *necktieGray*: `UIColor(red:0.823, green:0.843, blue:0.89, alpha:1)`
- *necktieBackground*: `UIColor(red:0.858, green:0.878, blue:0.913, alpha:1)`
- *necktieDisabled*: `UIColor(red:0.384, green:0.772, blue:0, alpha:1)`
- *necktiePending*: `UIColor(red:0.384, green:0.772, blue:0, alpha:1)`
- *necktieGradientStart*: `UIColor(red:0.09, green:0.741, blue:1, alpha:1)`
- *necktieGradientEnd*: `UIColor(red:0.435, green:0.407, blue:0.976, alpha:1)`

##Fonts

*Roboto* in different variants and sizes. Included in `Resources/Fonts`.

- **Headings**: 18, Light
- **Body**: 12, Regular
- **Menu item**: 13, Regular

##Sections

###Dashboard

Dashboard is a `UICollectionView` with different cells defined in `DashboardCell.swift`:

1. Summary cell with four sections: `DashboardSummaryCell`,
2. Circular chart made with *KDCircularProgress*: `DashboardProgressCell`,
3. Line chart made with *ScrollableGraphView*: `DashboardGraphCell`,
4. Bar graph made with *ScrollableGraphView*: `DashboardBarGraphCell`.

Don't forget to set *UICollectionViewItem* size for any new cell type you add. Width is fixed to one cell on iPhone (*395* on iPhone 6/7), height is variable for each cell.

In `viewWillAppear(animated:)` there is intro animation done with *RevealingSplashView* (run only once, set in UserDefaults).

###TableViews

To create a new section with `UITableView`:

1. Create empty `UIViewController` in storyboard,
2. Drag `UITableView` to this controller and change its class to `TableView` (defined in *TableView.swift*),
3. Set constraints to `0` on top and bottom, and `8` to left and right.

This will automatically add *header* and *footer* with rounded corners and sets insets as needed. These properties are `@IBInspectable`.

To set fixed section header:

1. Add empty `UIView` to tableView and set its class to `SectionHeaderView` (defined in *SectionHeaderView.swift*),
2. Connect it as *IBOutlet* to viewController,
3. Return it in `tableView(tableView: viewForHeaderInSection:)` and don't forget to set its height (default should be *36*) in `tableView(tableView: heightForHeaderInSection:)`.

This subclass draws a line at bottom as separator.

##Networking

This project uses *Alamofire* library for all the networking. To ensure all (authorized) requests have *OAuth2* token embedded, all requests should use `APIManager.sharedManager` (instead of plain `Alamofire`).

To map object use *AlamofireObjectMapper* (*ObjectMapper*):

	.responseObject(keyPath: "object") { (response: DataResponse<Object>) in }

or to map array of objects:

	.responseArray(keyPath: "array") { (response: DataResponse<[Object]>) in }

*Object* is a class which conforms to `Mappable` protocol.

##Libraries

###KDCircularProgress

1. Place *UIView* in storyboard, change class to `UICircularProgressRingView` and connect outlet to view controller. It's `@IBDesignable` so customization is easy via Interface Builder.
2. To set value: `animate(fromAngle: 0, toAngle: 265, duration: 0.5, completion: nil)`. This sets value to 265 degrees and animation duration to 0.5 seconds.
3. Set `label` and `description` to display values inside the circle.

For more info see documentation<sup id="an3">[3](#fn3)</sup>.

###ScrollableGraphView

1. Add *UIView* to storyboard, set class to `ScrollableGraphView` and connect the outlet. Customization can be done via Interface Builder.
2. Set data with `set(data: [Double], withLabels: [String])`

For more info see documentation<sup id="an4">[4](#fn4)</sup>.

###SwiftyUserDefaults

Simplifies usage of NSUserDefaults. Some important keys are defined in `Constants.swift`.

- **Defining**: `static let name = DefaultsKey<Type>("key")`
- **Reading**: `let name = Defaults[.name]`
- **Writing**: `Defaults[.name] = value`

For more info see documentation<sup id="an2">[2](#fn2)</sup>.

###KeychainAccess

KeychainAccess is a simple Swift wrapper for Keychain.

- **Instantiate**: `let keychain = Keychain(service: "bundle.id")`
- **Reading**: `let key = keychain["key"]`
- **Writing**: `keychain["key"] = "value"`

It is also possible to *write* and *read* using `do try catch` to get catch errors:

	do {
		try keychain.set("value", key: "key")
	}
	catch let error {
		print(error)
	}

For more info see documentation<sup id="an5">[5](#fn5)</sup>.

###SnapKit

Makes autolayout in code easy.

	var box = UIView()
	
	self.view.addSubview(box)
	box.snp.makeConstraints { (make) -> Void in
		make.width.height.equalTo(50)
		make.center.equalTo(self.view)
	}

This creates a 50x50 points box in the center.

For more info see documentation<sup id="an6">[6](#fn6)</sup>.

##Links

<a name="fn1">**1.**</a> [https://github.com/teodorpatras/SideMenuController](https://github.com/teodorpatras/SideMenuController) [↩](#an1)

<a name="fn2">**2.**</a> [https://github.com/radex/SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults) [↩](#an2)

<a name="fn3">**3.**</a> [https://github.com/kaandedeoglu/KDCircularProgress](https://github.com/kaandedeoglu/KDCircularProgress) [↩](#an3)

<a name="fn4">**4.**</a> [https://github.com/philackm/Scrollable-GraphView](https://github.com/philackm/Scrollable-GraphView) [↩](#an4)

<a name="fn5">**5.**</a> [https://github.com/kishikawakatsumi/KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) [↩](#an5)

<a name="fn6">**6.**</a> [https://github.com/SnapKit/SnapKit](https://github.com/SnapKit/SnapKit) [↩](#an6)
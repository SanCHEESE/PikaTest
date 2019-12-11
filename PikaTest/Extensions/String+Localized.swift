import Foundation

extension String {
	var localized: String {
		return NSLocalizedString(self, tableName: "Localizable", value: "**\(self)**", comment: "")
	}
	
	func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
		return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
	}
}

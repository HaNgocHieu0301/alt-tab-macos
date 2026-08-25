import Foundation

/// Single-source-of-truth declaration for a macro preference: its key and default.
struct PreferenceDefinition<T: MacroPreference & CaseIterable & Equatable> {
    let key: String
    let `default`: T

    /// Read the currently-stored value. Passes through `CachedUserDefaults` so it's cheap on the hot path.
    func read() -> T {
        CachedUserDefaults.macroPref(key, Array(T.allCases))
    }
}

/// Registry of preferences that also have a per-shortcut-slot override (index 0).
enum ProGatedPreferences {
    static let appearanceStyle = PreferenceDefinition<AppearanceStylePreference>(
        key: "appearanceStyle", default: .thumbnails)

    static let appearanceSize = PreferenceDefinition<AppearanceSizePreference>(
        key: "appearanceSize", default: .auto)

    static let shortcutStyle = PreferenceDefinition<ShortcutStylePreference>(
        key: "shortcutStyle", default: .focusOnRelease)
}

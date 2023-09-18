import Foundation
import FamilyControls

class ScreenTimeAppSelectViewModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let userDefaultsKey = "ScreenTimeSelection"
    
    init() {
        // Load saved selection when the view model is initialized
        if let savedSelection = savedSelection() {
            activitySelection = savedSelection
        }
    }

    // saves all the selections passed into activitySelection
    func saveSelection() {
        let defaults = UserDefaults.standard
        if let encodedSelection = try? encoder.encode(activitySelection) {
            defaults.set(encodedSelection, forKey: userDefaultsKey)
        }
    }

    // returns the last selected activities
    func savedSelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: userDefaultsKey) else { return nil }

        if let decodedSelection = try? decoder.decode(FamilyActivitySelection.self, from: data) {
            return decodedSelection
        } else {
            return nil
        }
    }
}

import Foundation
import FamilyControls
import DeviceActivity

class ScreenTimeViewModel: ObservableObject {
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
    
    func startMonitoring(pod: Pods) {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: true
        )
        
        guard let selection: FamilyActivitySelection = self.savedSelection() else {
            print("saved selection not found")
            return
        }
        
        let event = DeviceActivityEvent(
            applications: selection.applicationTokens,
            categories: selection.categoryTokens,
            webDomains: selection.webDomainTokens,
            threshold: DateComponents(hour: pod.goal)
        )
        
        let center = DeviceActivityCenter()
        
        center.stopMonitoring()
        
        let activity = DeviceActivityName("MyApp.ScreenTime")
        let eventName = DeviceActivityEvent.Name("\(pod.podID!).\(FirestoreFunctions.system.CURRENT_USER_UID)") // used to differentiate between each event
        
        do {
            try center.startMonitoring(
                activity,
                during: schedule,
                events: [
                    eventName: event
                ]
            )
            print("began monitoring")
        } catch {
            print("Error starting ScreenTimeMonitoring")
        }
        
    }
}

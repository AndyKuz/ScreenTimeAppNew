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

    // returns the last selected activities from user Defaults
    func savedSelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: userDefaultsKey) else { return nil }

        if let decodedSelection = try? decoder.decode(FamilyActivitySelection.self, from: data) {
            return decodedSelection
        } else {
            return nil
        }
    }
    
    func endMonitoring(pod: Pods) { // stops monitoring screentime for specific pod
        let center = DeviceActivityCenter()
        center.stopMonitoring([DeviceActivityName(pod.podID)])
    }
    
    func beginMonitoring(pod: Pods) {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: true
        )
        
        guard let selection: FamilyActivitySelection = self.savedSelection() else {
            print("beginMonitoring(): saved selection not found")
            return
        }
        
        let event = DeviceActivityEvent(
            applications: selection.applicationTokens,
            categories: selection.categoryTokens,
            webDomains: selection.webDomainTokens,
            threshold: DateComponents(hour: pod.goal)
        )
        
        let center = DeviceActivityCenter()
        
        // monitors screentime for each pod
        let activity = DeviceActivityName(pod.podID)
        let eventName = DeviceActivityEvent.Name("ScreenTimeMonitoring")
        
        do {
            try center.startMonitoring(
                activity,
                during: schedule,
                events: [
                    eventName: event
                ]
            )
        } catch {
            print("beginMonitoring(): Error starting ScreenTimeMonitoring")
        }
        
    }
}

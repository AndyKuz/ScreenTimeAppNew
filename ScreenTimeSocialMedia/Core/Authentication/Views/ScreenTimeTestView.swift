import SwiftUI
import FamilyControls

struct ScreenTimeTestView: View {
    @StateObject var screenTimeManager = ScreenTimeAppSelectViewModel()
    @State private var pickerIsPresented = false

    var body: some View {
        VStack {
            Button(action: {
                pickerIsPresented = true
            }) {
                Text("Select Apps")
            }
        }
        .familyActivityPicker(
            isPresented: $pickerIsPresented,
            selection: $screenTimeManager.activitySelection
        )
        .onChange(of: screenTimeManager.activitySelection) {
            screenTimeManager.saveSelection()
        }
    }
}

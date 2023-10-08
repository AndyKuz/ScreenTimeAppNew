import SwiftUI

struct HomeView: View {
    @State var pods: [Pods] = []
    @State var isSheetPresented = false
    @State var errorMessage = ""

    var body: some View {
        List {
            ForEach(pods, id: \.podID) { pod in
                PodsView(pod: pod)
            }
            Section(footer:
                HStack(alignment: .center) {
                    Spacer()

                    Button("Button") {
                        isSheetPresented = true
                    }
                    Spacer()

            }) {
                EmptyView()
            }
        }
        .onAppear() {
            FirestoreFunctions.system.loadPods { pod in
                pods = pod
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            PodSelectionView(isSheetPresented: $isSheetPresented, pods: $pods)
        }
    }
}

#Preview {
    HomeView()
}


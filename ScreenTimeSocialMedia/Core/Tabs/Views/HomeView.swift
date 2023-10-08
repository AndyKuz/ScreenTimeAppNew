import SwiftUI
import UserNotifications

struct HomeView: View {
    var permissionsManager = PermissionsManagerViewModel()
    
    @State var pods: [Pods] = []
    @State var isSheetPresented = false
    @State var errorMessage = ""

    var body: some View {
        ZStack {
            List {
                // display each pod
                ForEach(pods, id: \.podID) { pod in
                    PodsView(pod: pod)
                }
                .onMove { indexSet, index in    // adds hold to move functionality to each pod
                    pods.move(fromOffsets: indexSet, toOffset: index)
                }
                
                Section(footer:
                            HStack(alignment: .center) {
                    Spacer()
                    
                    Button(action: {
                        if pods.count >= 4 {
                            errorMessage = "Maximum pod amount reached" // print error message
                            
                            // timer to remove error message after 3 seconds
                            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                withAnimation {
                                    errorMessage = ""
                                }
                            }
                        } else {
                            // bring up Pods Selection View as sheet
                            isSheetPresented = true
                        }
                    }) {
                        HStack {
                            Spacer()
                            Circle()
                                .foregroundColor(Color.blue)
                                .frame(width: 25, height: 25)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .bold))
                                )
                            Text("Add New Pod")
                            Spacer()
                        }
                        Spacer()
                    }
                    
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
            
            // show error message
            VStack {
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(errorMessage.isEmpty ? 0.0 : 1.0) // hide error message if error message empty
            }
        }
    }
}


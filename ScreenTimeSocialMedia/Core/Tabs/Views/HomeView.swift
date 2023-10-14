import SwiftUI

struct HomeView: View {
    @State var pods: [Pods] = []
    @State var isSheetPresented = false
    @State var errorMessage = ""
    
    @State var podsRequestList: [Pods] = []
    @State var numPodsRequests = 0

    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: PodsInviteView(podsRequestList: $podsRequestList, pods: $pods, fetchUsersPodsRequests: fetchUsersPodsRequests)) {
                    ZStack {
                        // clickable bell at top right of the screen
                        Image(systemName: "bell.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 30, height: 32)
                            .padding()
                        
                        // display number over bell signifying num friend requests
                        if numPodsRequests > 0 {
                            Text("\(numPodsRequests)")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.red).frame(width: 20, height: 20))
                                .offset(x: 8, y: -8)
                        }
                    }
                }
                
            }
            List {
                // display each pod
                ForEach(pods, id: \.podID) { pod in
                    PodsView(pod: pod, fetchUsersPods: fetchUsersPods)
                }
                .onMove { indexSet, index in    // adds hold to move functionality to each pod
                    pods.move(fromOffsets: indexSet, toOffset: index)
                }
                
                Section(footer:
                            HStack(alignment: .center) {
                    Spacer()
                    
                    VStack {
                        // error message display
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .opacity(errorMessage.isEmpty ? 0.0 : 1.0) // hide error message if error message empty
                            .padding()
                        
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
                    }
                    
                }) {
                    EmptyView()
                }
            }
            .onAppear() {
                // load all current pods
                FirestoreFunctions.system.loadPods { pod in
                    pods = pod
                }
                
                FirestoreFunctions.system.loadPodRequests { pod in
                    podsRequestList = pod
                    numPodsRequests = podsRequestList.count
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                PodSelectionView(isSheetPresented: $isSheetPresented, pods: $pods)
            }
        }
    }
    
    // manually updates pods list
    // used on pod deletion when listener isn't called
    func fetchUsersPods() {
        FirestoreFunctions.system.queryPods { pods in
            self.pods = pods
        }
    }
    
    func fetchUsersPodsRequests() {
        FirestoreFunctions.system.queryPodsRequests { pods in
            self.podsRequestList = pods
            self.numPodsRequests = self.podsRequestList.count
        }
    }
}


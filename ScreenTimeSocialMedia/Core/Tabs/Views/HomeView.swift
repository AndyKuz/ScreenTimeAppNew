import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @ObservedObject var db = FirestoreFunctions.system
    
    @State var isSheetPresented = false
    @State var errorMessage = ""
    
    @State var podsRequestList: [Pods] = []
    @State var numPodsRequests = 0
    
    @State var didAppear = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: PodsInviteView(podsRequestList: $podsRequestList, fetchUsersPodsRequests: fetchUsersPodsRequests)) {
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
                ForEach(db.allPodsList, id: \.podID) { pod in
                    PodsView(pod: pod, fetchUsersPods: fetchUsersPods)
                }
                .onMove { indexSet, index in    // adds hold to move functionality to each pod
                    db.allPodsList.move(fromOffsets: indexSet, toOffset: index)
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
                            if db.allPodsList.count >= 4 {
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
                // request user to enable notifications
                PermissionsManagerViewModel().notificationsRequest()
                
                // call user's pods listen on first appear
                if !didAppear {
                    db.listenUsersPods() {}
                    didAppear = true
                }
                
                db.loadPodRequests { newPods in
                    podsRequestList = newPods
                    numPodsRequests = podsRequestList.count
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                PodSelectionView(isSheetPresented: $isSheetPresented)
            }
        }
    }
    
    // manually updates pods list
    // used on pod deletion when listener isn't called
    func fetchUsersPods() {
        db.queryPods { newPods in
            db.allPodsList = newPods
        }
    }
    
    // manually updates pods list
    // used on pod deletion when listener isn't called
    func fetchUsersPodsRequests() {
        db.queryPodsRequests { newPods in
            self.podsRequestList = newPods
            self.numPodsRequests = self.podsRequestList.count
        }
    }
}


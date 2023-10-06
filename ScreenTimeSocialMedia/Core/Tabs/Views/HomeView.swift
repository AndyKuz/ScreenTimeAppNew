import SwiftUI

struct HomeView: View {
    @State var pods: [Pods] = []
    @State var isSheetPresented = false
    @State var errorMessage = ""

    var body: some View {
        /*ZStack {
            VStack {
                List {
                    ForEach(pods) { pod in
                        HStack {
                            pod
                        }
                    }
                    .onMove { indexSet, index in    // adds hold to move functionality to each pod
                        pods.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }*/
            
            /*VStack {
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(errorMessage.isEmpty ? 0.0 : 1.0) // hide error message if error message empty
                
                Button(action: {
                    if(pods.count >= 4) {
                        errorMessage = "Maximum pod amount reached" // print error message
                        
                        // timer to remove error message after 3 seconds
                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                            withAnimation {
                                errorMessage = ""
                            }
                        }
                    } else {
                        isSheetPresented.toggle()
                    }
                }) {
                    Circle()
                        .foregroundColor(Color.blue)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        )
                }
                .padding()
            }
        }*/
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


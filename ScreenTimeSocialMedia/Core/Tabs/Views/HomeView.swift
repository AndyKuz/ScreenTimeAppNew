import SwiftUI

struct HomeView: View {
    @State private var pods: [PodsView] = []
    @State private var isSheetPresented = false
    @State var errorMessage = ""

    var body: some View {
        ZStack {
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
            }
            
            VStack {
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(errorMessage.isEmpty ? 0.0 : 1.0) // hide error message if error message empty
                
                Button(action: {
                    // Add your action code here
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
        }
        .sheet(isPresented: $isSheetPresented) {
            PodSelectionView(isSheetPresented: $isSheetPresented, addPod: {name, group, timeFrame, totalNumStrikes in
                let newPod = PodsView(podName: name,
                                      group: group,
                                      timeFrame: timeFrame,
                                      totalNumStrikes: totalNumStrikes)
                pods.append(newPod)
            })
        }
    }
}

#Preview {
    HomeView()
}


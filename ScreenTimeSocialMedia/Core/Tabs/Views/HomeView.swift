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
                    .onDelete { indexSet in     // adds swipe to delete functionality to each pod
                        pods.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in    // adds hold to move functionality to each pod
                        pods.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            
            VStack {
                Spacer()
                // shows error message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    // Add your action code here
                    if(pods.count >= 4) {
                        // print error message
                        errorMessage = "Maximum pod amount reached"
                    } else {
                        errorMessage = ""
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


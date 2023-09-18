import SwiftUI

struct HomeView: View {
    @State private var pods: [PodsView] = []
    @State private var isSheetPresented = false

    var body: some View {
        VStack {
            List {
                ForEach(pods) { pod in
                    HStack {
                        pod
                    }
                }
            }

            Button(action: {
                // Add your action code here
                if(pods.count >= 4) {
                    // print error message
                } else {
                    isSheetPresented.toggle()
                    // let newPod = PodsView(name: "Pod1", description: "Description", group:.screenTime)
                    // pods.append(newPod)
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
        .sheet(isPresented: $isSheetPresented) {
            PodSelectionView(isSheetPresented: $isSheetPresented, addPod: {name, group in
                let newPod = PodsView(name: name, group: group)
                pods.append(newPod)
            })
        }
    }
}

#Preview {
    HomeView()
}


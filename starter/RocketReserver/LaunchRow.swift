import SwiftUI
import RocketReserverAPI

struct LaunchRow: View {
    let launch: LaunchListQuery.Data.Launches.Launch
    private let placeholderImg = Image("placeholder")
    
    var body: some View {
        HStack {
            placeholderImg
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text("Mission Name")
                Text(launch.site ?? "Launch Site")
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .padding(4)
    }
}

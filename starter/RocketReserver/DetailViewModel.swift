import SwiftUI
import RocketReserverAPI

class DetailViewModel: ObservableObject {
    let launchID: RocketReserverAPI.ID
    
    @Published var launch: LaunchDetailsQuery.Data.Launch?
    @Published var isShowingLogin = false
    @Published var appAlert: AppAlert?
    
    init(launchID: RocketReserverAPI.ID) {
        self.launchID = launchID
    }
    
    func loadLaunchDetails() {
        guard launchID != launch?.id else {
            return
        }
        
        Network.shared.apollo.fetch(query: LaunchDetailsQuery(launchId: launchID)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let launch = graphQLResult.data?.launch {
                    self?.launch = launch
                }
                
                if let errors = graphQLResult.errors {
                    self?.appAlert = .errors(errors: errors)
                }
            case .failure(let error):
                self?.appAlert = .errors(errors: [error])
            }
        }
    }
    
    func bookOrCancel() {
        guard self.isLoggedIn() else {
            isShowingLogin = true
            return
        }
        
        // TODO (Part II - Define additional mutations)
    }
    
    private func bookTrip() {
        print("Book Trip!")
        // TODO (Part II - Define additional mutations)
    }
    
    private func cancelTrip() {
        print("Cancel Trip!")
        // TODO (Part II - Define additional mutations)
    }
    
    private func isLoggedIn() -> Bool {
        // TODO (Part II - Write your first mutation)
        return false
    }
    
}

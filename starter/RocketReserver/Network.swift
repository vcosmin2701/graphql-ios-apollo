import Apollo
import Foundation
import ApolloWebSocket

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        let webSocket = WebSocket(
            // wss is the protocol to secure websocket
            url: URL(string: "wss://apollo-fullstack-tutorial.herokuapp.com/graphql")!,
            protocol: .graphql_ws
        )
        
        let webSocketTransport = WebSocketTransport(websocket: webSocket)
        
        let splitTransport = SplitNetworkTransport(
            uploadingNetworkTransport: transport,
            webSocketNetworkTransport: webSocketTransport
        )
        
        return ApolloClient(networkTransport: transport, store: store)
    }()
}


import ComposableArchitecture
import SwiftUI

struct ServiceView: View {
    let store: StoreOf<HostApp>
    @State var tag = 1

    var body: some View {
        WithPerceptionTracking {
            SidebarTabView(tag: $tag) {
                WithPerceptionTracking {
                    ScrollView {
                        CodeiumView().padding()
                    }.sidebarItem(
                        tag: 1,
                        title: "Codeium",
                        subtitle: "Suggestion",
                        image: "globe"
                    )
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(store: .init(initialState: .init(), reducer: { HostApp() }))
    }
}


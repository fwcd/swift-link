#if os(iOS)
import SwiftUI
import CLinkKit

public struct LinkSettingsView: UIViewControllerRepresentable {
    @Environment(Link.self) private var link
    
    public init() {}

    public func makeUIViewController(context: Context) -> ABLLinkSettingsViewController {
        ABLLinkSettingsViewController.instance(link.linkRef)
    }
    
    public func updateUIViewController(_ uiViewController: ABLLinkSettingsViewController, context: Context) {
        // Do nothing
    }
}

#Preview {
    LinkSettingsView()
        .environment(Link())
}
#endif

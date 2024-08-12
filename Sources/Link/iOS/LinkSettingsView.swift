#if os(iOS)
import SwiftUI
import CLinkKit

public struct LinkSettingsView: UIViewControllerRepresentable {
    @Environment(LinkManager.self) private var linkManager
    
    public init() {}

    public func makeUIViewController(context: Context) -> ABLLinkSettingsViewController {
        ABLLinkSettingsViewController.instance(linkManager.linkRef)
    }
    
    public func updateUIViewController(_ uiViewController: ABLLinkSettingsViewController, context: Context) {
        // Do nothing
    }
}

#Preview {
    LinkSettingsView()
        .environment(LinkManager())
}
#endif

#if os(iOS)
import SwiftUI
import CLinkKit

public struct LinkSettingsView: UIViewControllerRepresentable {
    private let link: Link
    
    public init(link: Link) {
        self.link = link
    }

    public func makeUIViewController(context: Context) -> ABLLinkSettingsViewController {
        ABLLinkSettingsViewController.instance(link.linkRef)
    }
    
    public func updateUIViewController(_ uiViewController: ABLLinkSettingsViewController, context: Context) {
        // Do nothing
    }
}

#Preview {
    LinkSettingsView(link: Link())
}
#endif

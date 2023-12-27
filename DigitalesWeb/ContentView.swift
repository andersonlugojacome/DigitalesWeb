//
//  ContentView.swift
//  DigitalesWeb
//
//  Created by Anderson Lugo Jacome on 27/12/23.
//

import SwiftUI
import SwiftData
import WebKit

//struct WebView: UIViewRepresentable{
//    let urlString: String
//    
//    func makeUIView(context: Context) -> WKWebView{
//        guard let url = URL(string: urlString) else {
//            return WKWebView()
//        }
//        let webView = WKWebView()
//        webView.load(URLRequest(url:url))
//        return webView
//        
//    }
//    func updateUIView(_ uiView:WKWebView, context: Context){
//        
//    }
//    
//    
//}



//agrego una funciona que sume dos numeros
func suma(a:Int, b:Int)->Int{
    return a+b
}




struct RefreshableWebView: UIViewRepresentable{
    let urlString: String
    @Binding var isRefreshing: Bool
    
    func makeCoordinator()-> Coordinator{
        Coordinator(self, urlString:urlString)
    }
    
    func makeUIView(context: Context) -> WKWebView{
        let webView = WKWebView()
        webView.scrollView.refreshControl = UIRefreshControl()
        webView.scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        loadRequest(in: webView)
        return webView
    }
    
    func updateUIView(_ uiView:WKWebView, context:Context){
        if isRefreshing {
            loadRequest(in: uiView)
        }
    }
    private func loadRequest(in webView: WKWebView){
        if let url = URL(string:urlString){
            webView.load(URLRequest(url:url))
        }
        isRefreshing=false
    }
    
    // Class Coordinator
    class Coordinator:NSObject{
        var control: RefreshableWebView
        let urlString: String
        
        init(_ control: RefreshableWebView, urlString: String) {
            self.control = control
            self.urlString = urlString
        }
        @objc func handleRefreshControl(sender: UIRefreshControl){
            sender.endRefreshing()
            control.isRefreshing = true
        }
    }
    
}


struct ContentView: View {
    @State private var isRefreshing = false

    var body: some View {
        RefreshableWebView(urlString: "https://digitalesweb.com", isRefreshing: $isRefreshing)
    }
}


//
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

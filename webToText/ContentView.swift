//
//  ContentView.swift
//  webToText
//
//  Created by Ho wing Cheng on 5/4/2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var bookUrl: String = ""
    public var myWebView = WebView(url: URL(string: "https://gaia.cs.umass.edu/wireshark-labs/TCP-wireshark-file1.html")!)
    
    var body: some View {
        VStack {
            myWebView
                .frame(width: 400.0, height: 500.0)
            
            TextField(
                "Placeholder", text: $bookUrl
            )
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                print("Hello world")
                myWebView.runJavascript()
            }
            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            .onSubmit {
                //bookUrl
                
                /*
                 https://stackoverflow.com/questions/24016142/how-do-i-make-an-http-request-in-swift
                let url = URL(string: "https://www.stackoverflow.com")!

                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data = data else { return }
                    print(String(data: data, encoding: .utf8)!)
                }

                task.resume()
                 */
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    var wkWebView: WKWebView = WKWebView(frame: .zero)

    func makeUIView(context: Context) -> WKWebView {
//        let webConfiguration = WKWebViewConfiguration()
//        let wkcontentController = WKUserContentController()
//
//        webConfiguration.userContentController = wkcontentController
//        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        return wkWebView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func runJavascript() {
        wkWebView.evaluateJavaScript("document.body.style.backgroundColor = 'red'", completionHandler: nil)
        print("javascript ran")
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
//            ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/).progressViewStyle(CircularProgressViewStyle())
            myWebView
                .frame(width: 400.0, height: 500.0)
            
            TextField(
                "Please input the book url", text: $bookUrl
            )
            Button("Get web as string") {
                //myWebView.runJavascript("document.body.style.backgroundColor = 'red'")
                let javascriptString = "(function() {body = document.body;sel = window.getSelection();range = document.createRange();range.selectNodeContents(body);sel.removeAllRanges();sel.addRange(range);selString = sel.toString();return selString;})();"
                let webText = myWebView.runJavascriptGetReturn(javascriptString)
                print("Below are webText\n")
                print(webText)
                

            }
            .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    var wkWebView: WKWebView = WKWebView(frame: .zero)

    func makeUIView(context: Context) -> WKWebView {
        return wkWebView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func runJavascript(_ jsString: String) {
        wkWebView.evaluateJavaScript(jsString, completionHandler: nil)
    }
    
    func runJavascriptGetReturn(_ jsString: String) -> NSString{
        var webText: NSString = ""
        var finished = false
        wkWebView.evaluateJavaScript(jsString) { (result, error) in
            if let result = result {
                webText = result as! NSString
            }else {
                webText = "ERROR"
            }
            finished = true
        }
        while !finished {
            RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
        }
        return webText
    }
    
    func loadURL(_ funURL: String){
        let myURL = URL(string:funURL)
        let myRequest = URLRequest(url: myURL!)
        let loadStatus = wkWebView.load(myRequest)
        print(loadStatus ?? "default load status")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

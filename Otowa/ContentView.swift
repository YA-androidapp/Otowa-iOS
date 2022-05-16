//
//  ContentView.swift
//  Otowa
//
//  Created by Yu on 2022/05/10.
//

import SwiftUI
import TwitterAPIKit

struct ContentView: View {
    @State var prefix:String = ""
    @State var suffix:String = ""
    @State var tweet:String = ""
    
    @State private var clearLongPressed = false
    
    @ObservedObject var manager = LocationManager()
    
    var twAccess = TwitterAccess()
    
    var body: some View {
        VStack{
            HStack{
            Text("Otowa")
                .padding()
                
            Spacer()
            
            Menu {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "doc")
                        Text("KML file")
                    }
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ladybug")
                        Text("Twitter API")
                    }
                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }) {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                } label: {
                    Image(systemName: "menucard")
                }.padding(10)
            }
                .foregroundColor(Color.white)
                .background(Color.purple)
        
            HStack{
                Button(action: {
                    if clearLongPressed {
                        clearLongPressed = false
                    } else {
                        self.tweet = ""
                    }
                }, label: {
                    Text("CLEAR")
                })
                    .simultaneousGesture(
                        LongPressGesture().onEnded{ _ in
                            self.tweet = ""
                            self.prefix = ""
                            self.suffix = ""
                            
                            clearLongPressed = true
                        }
                    )
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
                    .font(.footnote)
                
                VStack {
                    ZStack {
                        TextEditor(text: $prefix)
                            .frame(height: 35)
                            .font(.body)
                            .border(Color.gray,width: 1)
                        if self.prefix.isEmpty {
                            HStack {
                                Text("Prefix")
                                    .opacity(0.5)
                                    .padding(.horizontal, 5)
                                Spacer()
                            }
                        }
                    }
                    
                    ZStack {
                        TextEditor(text: $suffix)
                            .frame(height: 35)
                            .font(.body)
                            .border(Color.gray,width: 1)
                        
                        if self.suffix.isEmpty {
                            HStack {
                                Text("Suffix")
                                    .opacity(0.5)
                                    .padding(.horizontal, 5)
                                Spacer()
                            }
                        }
                    }
                }
                
                Button(action: {
//                    if self.tweet != "" {
//                        client.v2.tweet.postTweet(.init(text: self.tweet))
//                            .responseObject {response in
//                                print(response.prettyString)
//                            }
//                    }
                }, label: {
                    Text("Tweet")
                })
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
                    .font(.footnote)
            }
            .padding(.horizontal, 10)
            
            HStack{
                Button(action: {
                    let latitude = $manager.location.wrappedValue.coordinate.latitude
                    let longitude = $manager.location.wrappedValue.coordinate.longitude
                    let url = "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)"
                    
                    let database = Database()
                    let label = database.townDatastore.search(lat: latitude, lon: longitude)
                    if(label != nil){
                        self.tweet += label! + " " + url
                    }
                }, label: {
                    Text("LOCATE")
                })
                    .frame(width: 80, height: 120)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
                    .font(.footnote)
                
                ZStack(alignment: .top) {
                    TextEditor(text: $tweet)
                        .frame(height: 120)
                        .font(.body)
                        .border(Color.gray,width: 1)
                    if self.tweet.isEmpty {
                        HStack {
                            Text("Tweet")
                                .opacity(0.5)
                                .padding(5)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            
            HStack{
                Button(action: {}, label: {
                    Text("VOL--")
                })
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0, green: 0.6, blue: 0.8))
                    .font(.footnote)
                
                Button(action: {}, label: {
                    Text("VOL++")
                })
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0, green: 0.6, blue: 0.8))
                    .font(.footnote)
                
                Button(action: {}, label: {
                    Text("MAX")
                })
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0, green: 0.6, blue: 0.8))
                    .font(.footnote)
                
                Button(action: {}, label: {
                    Text("START LOGGING")
                })
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.red)
                    .background(Color(red: 0, green: 0.4, blue: 1))
                    .font(.footnote)
                
            }
            .padding(.horizontal, 10)
            
            Spacer(minLength: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

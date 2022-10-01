//
//  OrderStatusLiveActivity.swift
//  OrderStatus
//
//  Created by Mishana on 29.09.2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct OrderStatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct OrderStatusLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { context in
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(.systemMint).gradient)
                
                VStack {
                    HStack{
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("Start")
                            .foregroundColor(.white.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading )
                        HStack(spacing: -2) {
                            ForEach(["ipod", "iphone"], id: \.self) { image in
                                Image(systemName: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .background{
                                        Circle()
                                            .fill(Color(.systemMint))
                                            .padding(-2)
                                    }
                                    .background{
                                        Circle()
                                            .stroke(.white, lineWidth: 1.5)
                                            .padding(-2)
                                    }
                            }
                        }
                    }
                    
                    HStack(alignment: .bottom, spacing: 0){
                        VStack(alignment: .leading, spacing: 4){
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            Text(subMessage(status: context.state.status))
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .frame(maxHeight: .infinity, alignment: .leading)
                        .offset(y: 13)
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(Status.allCases, id: \.self) { type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                                                    .foregroundColor(context.state.status == type ? Color(.black) : .black.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32, height: context.state.status == type ? 45 : 32)
                                //                                    .background{
                                //                                        Circle()
                                //                                            .fill(context.state.status == type ? .white : .systemMint.opacity(0.8))
                                //                                    }
                                    .background(alignment: .bottom, content: {
                                        BottomArrow(status: context.state.status, type: type)
                                    })
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                        .overlay(alignment: .bottom, content: {
                            Rectangle()
                                .fill(.black.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal,27.5)
                        })
                        .padding(.leading, 15)
                        .padding(.trailing, -10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
                }
                .padding(15)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack{
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text("Store Pick")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading )
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack(spacing: -2) {
                        ForEach(["ipod", "iphone"], id: \.self) { image in
                            Image(systemName: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .background{
                                    Circle()
                                        .fill(Color(.black))
                                        .padding(-2)
                                }
                                .background{
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5)
                                        .padding(-2)
                                }
                        }
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    DynamicIslandStatusView(context: context)
                }
            } compactLeading: {
                Image(systemName: "heart.fill")
                    .font(.title3)
//                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .offset(x: -4)
            } compactTrailing: {
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
            } minimal: {
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
            }
        }
    }
    
    @ViewBuilder
    func DynamicIslandStatusView(context: ActivityViewContext<OrderAttributes>)-> some View {
        HStack(alignment: .bottom, spacing: 0){
            VStack(alignment: .leading, spacing: 4){
                Text(message(status: context.state.status))
                    .font(.callout)
                    .foregroundColor(.white)
                Text(subMessage(status: context.state.status))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxHeight: .infinity, alignment: .leading)
            .offset(x: 5,y: 5)

            HStack(alignment: .bottom, spacing: 0) {
                ForEach(Status.allCases, id: \.self) { type in
                    Image(systemName: type.rawValue)
                        .font(context.state.status == type ? .title2 : .body)
//                        .foregroundColor(context.state.status == type ? Color(.systemMint) : .white.opacity(0.7))
                        .frame(width: context.state.status == type ? 35 : 26, height: context.state.status == type ? 35 : 26)
//                        .background{
//                            Circle()
//                                .fill(context.state.status == type ? .white : .systemMint.opacity(0.8))
//                        }
                        .background(alignment: .bottom, content: {
                            BottomArrow(status: context.state.status, type: type)
                        })
                        .frame(maxWidth: .infinity)
                }

            }
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(height: 2)
                    .offset(y: 12)
                    .padding(.horizontal,27.5)
            })
            .offset(y: -5)
        }
    }
    
    
    
    @ViewBuilder
    func BottomArrow(status: Status, type: Status)->some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.black)
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(.black)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
            }
    }
    func message(status: Status)-> String {
         switch status {
         case .received:
           return "Start"
         case .progress:
           return "Process"
         case .ready:
           return "End"
         }
    }
    func subMessage(status: Status)-> String {
         switch status {
         case .received:
           return "Start"
         case .progress:
           return "Process"
         case .ready:
           return "End"
         }
    }
}

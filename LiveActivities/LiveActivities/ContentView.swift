//
//  ContentView.swift
//  LiveActivities
//
//  Created by Mishana on 29.09.2022.
//

import SwiftUI
import WidgetKit
import ActivityKit


struct ContentView: View {
    @State var currentID: String = ""
    @State var currentSelection: Status = .received
    var body: some View {
        NavigationStack {
            VStack{
                Picker(selection: $currentSelection) {
                    Text("Receivwd")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                } label: {
                }
                .labelsHidden()
                .pickerStyle(.segmented)

                Button("Start Activity") {
                    addLiveActivity()
                }
                .padding(.top)
                
                Button("Remove Activity"){
                    removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
                    activity.id == currentID
                }){
                    print("Activity Found")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        var updatedState = activity.contentState
                        updatedState.status = currentSelection
                        Task {
                            await activity.update(using: updatedState)
                        }
                    }
                }
            }
        }
    }
    
    func removeActivity() {
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                Task{
                    await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    func addLiveActivity() {
        let orderAttributes = OrderAttributes(orderNumber: 26000, orderItems: "Millk & Burger")
        let initialContentState = OrderAttributes.ContentState()
        
        do{
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, contentState: initialContentState, pushType: nil)
            currentID = activity.id
            print("Add success id: \(activity.id)")
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

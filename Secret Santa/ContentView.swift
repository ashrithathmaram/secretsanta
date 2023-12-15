import SwiftUI

struct ContentView: View {
    
    @State private var people = [String]()
    @State private var newPerson = ""
    @State private var isSubmitVisible = false

    var body: some View {
        ZStack {
            NavigationStack {
                VStack() {
                    Image(.festivemonkey)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Secret Santa")
                        .font(.custom("MountainsofChristmas-Bold", size: 46))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TextField("Enter a name", text: $newPerson)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            if !newPerson.isEmpty {
                                people.append(newPerson)
                                newPerson = ""
                            }
                            if people.count == 2 {
                                withAnimation {
                                    // Toggle the visibility state on button click
                                    isSubmitVisible.toggle()
                                }
                                
                            }
                        }
                        .padding()
                    
                    Button("Add Monkey") {
                        if !newPerson.isEmpty {
                            people.append(newPerson)
                            newPerson = ""
                        }
                        if people.count == 2 {
                            withAnimation {
                                // Toggle the visibility state on button click
                                isSubmitVisible.toggle()
                            }
                            
                        }
                    }
                    .foregroundColor (.wine)
                    //                .keyboardShortcut(.defaultAction)
                    //                .onSubmit {
                    //                    if !newPerson.isEmpty {
                    //                        people.append(newPerson)
                    //                        newPerson = ""
                    //                    }
                    //                    if people.count == 2 {
                    //                        withAnimation {
                    //                            // Toggle the visibility state on button click
                    //                            isSubmitVisible.toggle()
                    //                        }
                    //
                    //                    }
                    //                }
                    .padding()
                    
                    ForEach(people, id: \.self) { person in
                        Text(person)
                    }
                    
                    //              Spacer()
                    
                    Button("Clear") {
                        people = []
                        isSubmitVisible = false
                    }
                    .foregroundColor(.wine)
                    .padding()
                    
                    
                    if isSubmitVisible {
                        NavigationLink(
                            destination: ViewPage(people: people),
                            label: {
                                Text("Submit")
                                    .padding()
                                    .background(.wine)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        )
                        .padding()
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .navigationBarTitle("", displayMode: .inline)
                .background(Color(.bkground))
                .ignoresSafeArea(.all, edges:[.bottom, .top, .trailing])
            }
            
            }
            
        }
            
        
    struct ViewPage: View {
        
        let people: [String]
        let giftingOrder: [String]
        
        @State private var currentGiver: String
        @State private var currentReceiver: String
        @State private var alrShown : [Int]
        @State private var isTextVisible = false
        
        // Use an initializer to pass necessary parameters
        init(people: [String]) {
            self.people = people
            self.giftingOrder = people.shuffled()
            print(giftingOrder)
            
            let rand = Int.random(in: 0..<people.count)
            
            _alrShown = State(initialValue: [rand])
            _currentGiver = State(initialValue: giftingOrder[rand])
            
            var receiverIndex = rand + 1
            
            if receiverIndex == people.count {
                receiverIndex = 0
            }
            
            _currentReceiver = State(initialValue: giftingOrder[receiverIndex])
        }
        
        var body: some View {
            VStack {
                Text("\(currentGiver) will gift to ...")
                    .font(.custom("MountainsofChristmas-Bold", size: 35))
                    .padding()
                
                if isTextVisible {
                    Text(currentReceiver)
                        .font(.custom("MountainsofChristmas-Bold", size: 35))
                        .padding()
                    if people.count == alrShown.count {
                        Text("Done!")
                            .padding()
                    }
                    else {
                        Button(action: {
                            var rand = Int.random(in: 0..<people.count)
                            while alrShown.contains(rand){
                                rand = Int.random(in: 0..<people.count)
                            }
                            currentGiver = giftingOrder[rand]
                            
                            var receiverIndex = rand + 1
                            
                            if receiverIndex == people.count {
                                receiverIndex = 0
                            }
                            
                            currentReceiver = giftingOrder[receiverIndex]
                            
                            alrShown.append(rand)
                            
                            // Toggle the visibility state on button click
                            isTextVisible.toggle()
                        }) {
                            Text("Next")
                                .padding()
                                .background(Color.wine)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        // Toggle the visibility state on button click
                        isTextVisible.toggle()
                    }
                }) {
                    Text("Reveal")
                        .padding()
                        .background(Color.wine)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .opacity(isTextVisible ? 0 : 1) // Make the button disappear when text is visible
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color(.bkground))
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.font, Font.custom("MountainsofChristmas-Bold", size: 24))
    }
}

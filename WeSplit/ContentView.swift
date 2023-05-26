//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Tavares on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0 // This is really the index of the for loop so since we start at 2, the index of
    // a for loop output starts at 0 but the vlaue at zero is 2. So setting this default value to 0 shows 2 on the app
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tippercentages = [10, 15, 20, 25, 0]
    
    // This is a computed property
    var totalPerPerson: Double {
        // Calculate the total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    var totalCheckamount: Double {
        // This is the total check amount plus tip
        let totalTipSelection = Double(tipPercentage)
        let totalTipValue = checkAmount/100 * totalTipSelection
        let GrandTotal = checkAmount + totalTipValue
        
        return GrandTotal
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) // When you tap this text field, this tag will go true
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                
                Section{
//                    Picker("Tip percentage", selection: $tipPercentage){
//                        ForEach(tippercentages, id: \.self){
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text("\($0)%")
                        }
                    }
                } header: {
                    Text("Tip percentage")
                }
                
                
                Section {
                    Text(totalCheckamount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total check amount with tip")
                }
                
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                
            }
            .navigationTitle("WeSplit")

             //This adds a small toolbar to the top of the keyboard
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    
                    // This simply moves items over to the left or to the right of a view
                    Spacer()
                    
                    // When done is pressed this will then set the focus for the amount to false and hide the keyboard
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

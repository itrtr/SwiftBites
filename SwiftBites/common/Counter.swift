//
//  Counter.swift -> View responsible for increment or decrement the count
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI

struct Counter: View {
    @Binding var counterResult: Int
    var counterText: String
    var counterFrequency: Int

    var body: some View {
        HStack {
            Text(counterText).padding(.leading, 5)
            Spacer()
            HStack {
                VStack {
                    Image(systemName: "minus").font(.headline)
                }
                .padding(10)
                .onTapGesture {
                    if counterResult / counterFrequency > 1 {
                        counterResult -= counterFrequency
                    }
                }
                
                Divider()
                
                VStack {
                    Image(systemName: "plus").font(.headline)
                }
                .padding(10)
                .onTapGesture {
                    counterResult += counterFrequency
                }
            }
        }
    }
}

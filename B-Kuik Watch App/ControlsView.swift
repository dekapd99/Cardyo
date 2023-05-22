//
//  ControlsView.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI

struct ControlsView: View {
    //MARK: - PROPERTIES
    
    
    //MARK: - BODY
    var body: some View {
        HStack {
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                
                Text("Stop")
            }
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "pause")
                }
                .tint(Color.yellow)
                .font(.title2)
                
                Text("Pause")
            }
        }
    }//: - BODY
}

//MARK: - PREVIEW
struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}

//
//  AboutUs.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
      VStack {
        HStack {
          Image("Icon")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
          
          Image("WSKPolice")
            .resizable()
            .scaledToFit()
            
        }
        .padding(.leading, 20).padding(.trailing, 20).padding(.top, 20)
        HStack {
          
          Spacer()
          Text("Version 2.0")
            .font(.custom("Scada-Regular", size: 20))
          
            .foregroundColor(.gray)
            .multilineTextAlignment(.trailing)
            .padding(.trailing, 20)
          
        }
        
        
        Text("WSK Police - Оперативно-розыскная деятельность - мероприятия, выполняемые гласно и негласно уполномоченными на это государственными  органами с целью выявить, пресечь или раскрыть преступление, отыскать скрывающихся и пропавших без вести людей, установить имущество, подлежащее конфискации, добыть информацию о событиях и деяниях, опасных для государства.")
          .font(.custom("Scada-Regular", size: 20))
          .multilineTextAlignment(.center)
          .minimumScaleFactor(0.5)
          .padding()
        
        HStack(alignment: .top) {
          Image("WSKRussia")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 100)
            .padding(.leading, 10)
          Text("2019 \"WSK Police\"\nРазработано с любовью в\nWorldSkills Russia compition\nF6 Mobile Application Development")
            .font(.custom("Scada-Regular", size: 17))
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding()
          
          
        }
        Spacer()
      }
      .navigationBarTitle("About Us", displayMode: .inline)
      
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}

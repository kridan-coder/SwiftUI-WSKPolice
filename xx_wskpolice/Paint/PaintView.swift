//
//  PaintView.swift
//  xx_wskpolice
//
//  Created by Daniel Krivelev on 24.01.2022.
//

import SwiftUI

class PaintViewModel: ObservableObject {
  @Published var name = "Daniel"
}

struct Line {
  var points: [CGPoint]
  var color: Color
  var lineWidth: CGFloat
}

struct PaintView: View {
  @Environment(\.colorScheme) var colorScheme
  var isNavigationBarHidden = true
  
  @StateObject var viewModel = PaintViewModel()
  
  @State private var color = 0.5
  
  @State private var saturation = 1.0
  @State private var brightness = 1.0
  
  var chosenColor: Color {
    Color(hue: color, saturation: saturation, brightness: brightness)
  }
  
  var chosenWidth: Double {
    (width * 10 + 1).rounded()
  }
  
  @State private var width = 0.1
  
  @State private var lines: [Line] = []
  
  @State private var choosingColor = false
  @State private var choosingWidth = false
  
  @State private var isRubbing = false
  
  
  var body: some View {
    GeometryReader { screen in
      VStack {
        if choosingColor {
          HStack {
            Text("Choose Color")
            Rectangle()
              .frame(width: 10, height: 10)
              .foregroundColor(chosenColor)
            Slider(value: $color)
            Button("Apply") {
                choosingColor.toggle()
            }
          }.padding()
        } else if choosingWidth {
          HStack {
            Text("Choose Width")
            Text(String(chosenWidth))
            Slider(value: $width)
            Button("Apply") {
                choosingWidth.toggle()
            }
          }
          .padding()

        }
        
        
        else {
          HStack {
            Button {
              choosingColor.toggle()
            } label: {
              Image("RGBCircle")
                .resizable()
                .frame(width: 50, height: 50)
            }
            
            Spacer()
            
            Button {
              choosingWidth.toggle()
            } label: {
              Image("PencilPaint")
                .resizable()
                .frame(width: 50, height: 50)
            }
            

            
            Spacer()
            
            Button {
              withAnimation {
                
                isRubbing.toggle()
              }
              if colorScheme == .dark {
                brightness = brightness == 0 ? 1 : 0
              } else {
                saturation = saturation == 0 ? 1 : 0
              }
              
            } label: {
              Image("Rubber")
                .resizable()
                .frame(width: 50, height: 50)
            }
            .background {
              
              if isRubbing {
                Color.cyan
              } else {
                Color.clear
              }
            }
            
           
          }
          .padding(.leading).padding(.trailing).padding(.top)
          Rectangle()
            .frame(height: 1)
          Canvas { context, size in
            
            for line in lines {
              var path = Path()
              path.addLines(line.points)
              context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
            
          }
          .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged { value in
            let newPoint = value.location
            if value.translation.width + value.translation.height == 0 {
              lines.append(Line(points: [newPoint], color: chosenColor, lineWidth: CGFloat(chosenWidth)))
            } else {
              let index = lines.count - 1
              lines[index].points.append(newPoint)
            }
          })
        }
        
        
      }.navigationBarTitle("Paint", displayMode: .inline)
    }
    
  }
}

struct PaintView_Previews: PreviewProvider {
  static var previews: some View {
    PaintView()
  }
}


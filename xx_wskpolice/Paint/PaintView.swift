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
  var isNavigationBarHidden = true
  
  @StateObject var viewModel = PaintViewModel()
  
  @State var chosenColor = Color.gray
  @State var chosenWidth = 10
  
  @State private var lines: [Line] = []
  
  @State private var choosingColor = false
  @State private var choosingWidth = false
  
  
  var body: some View {
    GeometryReader { screen in
      VStack {
        HStack {
          Button {
            choosingColor.toggle()
          } label: {
            Image("RGBCircle")
              .resizable()
              .frame(width: 50, height: 50)
          }
          
          Spacer()
          Image("PencilPaint")
            .resizable()
            .frame(width: 50, height: 50)
          
          Spacer()
          Image("Rubber")
            .resizable()
            .frame(width: 50, height: 50)
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
        
      }.navigationBarTitle("Paint", displayMode: .inline)
    }
    
  }
}

struct PaintView_Previews: PreviewProvider {
  static var previews: some View {
    PaintView()
  }
}


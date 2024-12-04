//
//  CellView.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 19/11/24.
//

import SwiftUI

class ReusableViews {
    
    static func valuesCell(title: String,
                           theme: Theme,
                           horizontalPadding: CGFloat = 16,
                           cellHeight: CGFloat = 44,
                           addArrowRight: Bool = false,
                           value: String) -> some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                
                Text(title)
                    .font(.body)
                    .foregroundColor(theme.mainTextColour)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .minimumScaleFactor(1.0)
                    .padding(.leading, horizontalPadding)
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(value)
                    .font(.body)
                    .foregroundColor(theme.mainTextColour)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .padding(.trailing, addArrowRight ? 2 : 16)
                
            }
            
            if addArrowRight {
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.blue)
                    .padding(.trailing, horizontalPadding)
                
            }
            
        }
        .padding(5)
        .frame(height: cellHeight)
        .background(theme.mainBGColor2)
        .clipShape(RoundedRectangle(cornerRadius: cellHeight / 2.0))
        .padding(.horizontal, horizontalPadding)
        
    }
    
}

//
//  QRCodeView.swift
//  MateMatch
//
//  Created by Никита Котов on 09.02.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    
    @State private var name = "Никита"
    @State private var data = "21, Рыбное, Мужчина"
    
    let link = URL(string: "https://www.hackingwithswift.com")!
    
    @Binding var showQRCode: Bool
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let mainColor = Color(#colorLiteral(red: 0.964160502, green: 0.9669174552, blue: 1, alpha: 1))
    
    var body: some View {
        ZStack {
            
            mainColor.ignoresSafeArea()
            
            header
            
            buttonSend
            
        }
        .overlay {
            closeButton
        }
    }
    
    var header: some View {
        VStack {
            
            Text("Покажи QR-Code \nсвоим друзьям")
                .font(.system(size: 26, weight: .semibold, design: .rounded))
                .foregroundStyle(.black)
                .offset(y: -100)
                .multilineTextAlignment(.center)
            
            ZStack {
                QRCode
                    .padding()
                    .overlay {
                        Rectangle()
                            .stroke(
                                .linearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.8019003272, blue: 0.7793781757, alpha: 1)), Color(#colorLiteral(red: 0.001942681614, green: 0.8360390067, blue: 0.8042029738, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8829820752, blue: 0.8493685126, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9245410562, blue: 0.8803314567, alpha: 1))], startPoint: .leading, endPoint: .trailing)
                                ,
                                style: StrokeStyle(
                                    lineWidth: 2,
                                    lineCap: .round,
                                    dash: [114.5],
                                    dashPhase: 50
                                )
                            )
                    }
                
                Image("user-avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .offset(y: -180)
            }
            .padding(40)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
        }
    }
    
    var closeButton: some View {
        ZStack {
            Button {
                withAnimation { showQRCode = false }
            } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18))
                        .foregroundStyle(.black)
                        .padding(10)
                        .background {
                            Circle()
                                .fill(.white)
                        }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
    }
    
    var QRCode: some View {
        Image(uiImage: generateQRCode(from: "\(name)\n\(data)"))
            .resizable()
            .interpolation(.none)
            .scaledToFill()
            .frame(width: 200, height: 200)
    }
    
    var buttonSend: some View {
        VStack {
            
            ShareLink(
                item: Image(uiImage: generateQRCode(from: "\(name)\n\(data)")),
                preview:
                    SharePreview("\(name)\n\(data)",
                    image:
                    Image(uiImage: generateQRCode(from: "\(name)\n\(data)"))
                        .interpolation(.none)))
            {
                Image(systemName: "square.and.arrow.up")
                Text("Отправить")
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
            }
            .padding(.horizontal, 40)
            .frame(maxHeight: UIScreen.main.bounds.height / 2, alignment: .bottom)
            .offset(y: 70)

        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRCodeView(showQRCode: .constant(false))
}

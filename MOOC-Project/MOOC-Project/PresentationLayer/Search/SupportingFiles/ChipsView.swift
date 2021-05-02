//
//  ChipsView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

//struct ChipsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct ChipsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChipsView()
//    }
//}
//
//import SwiftUI
//
//struct ChipsDataModel: Identifiable {
//    let id = UUID()
//    @State var isSelected: Bool
//    let systemImage: String
//    let titleKey: LocalizedStringKey
//}
//
//class ChipsViewModel: ObservableObject {
//    @Published var dataObject: [ChipsDataModel] = [ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil Circle")]
//
//    func addChip() {
//        dataObject.append(ChipsDataModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil"))
//    }
//
//    func removeLast() {
//        guard dataObject.count != 0 else {
//            return
//        }
//        dataObject.removeLast()
//    }
//}
//
//struct ContentView: View {
//    @StateObject var viewModel = ChipsViewModel()
//    var body: some View {
//        VStack {
//            ScrollView {
//                ChipsContent(viewModel: viewModel)
//            }
//            Spacer()
//            HStack {
//                Spacer()
//                Button("Remove Chips") {
//                    withAnimation {
//                        viewModel.removeLast()
//                    }
//                }.padding(.all, 40).accentColor(.red)
//                Spacer()
//                Button("Add Chips") {
//                    withAnimation {
//                        viewModel.addChip()
//                    }
//                }.padding(.all, 40)
//                Spacer()
//            }
//
//
//        }
//    }
//}
//
//struct ChipsContent: View {
//    @ObservedObject var viewModel = ChipsViewModel()
//    var body: some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
//        return GeometryReader { geo in
//                ZStack(alignment: .topLeading, content: {
//
//                ForEach(viewModel.dataObject) { chipsData in
//                    Chips(systemImage: chipsData.systemImage,
//                          titleKey: chipsData.titleKey,
//                          isSelected: chipsData.isSelected)
//                        .padding(.all, 5)
//                        .alignmentGuide(.leading) { dimension in
//                            if (abs(width - dimension.width) > geo.size.width) {
//                                width = 0
//                                height -= dimension.height
//                            }
//
//                            let result = width
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                width = 0
//                            } else {
//                                width -= dimension.width
//                            }
//                            return result
//                          }
//                        .alignmentGuide(.top) { dimension in
//                            let result = height
//                            if chipsData.id == viewModel.dataObject.last!.id {
//                                height = 0
//                            }
//                            return result
//                        }
//                }
//            })
//        }.padding(.all, 10)
//    }
//}
//
//
//struct Chips: View {
//    let systemImage: String
//    let titleKey: LocalizedStringKey
//    @State var isSelected: Bool
//    var body: some View {
//        HStack {
//            Image.init(systemName: systemImage).font(.title3)
//            Text(titleKey).font(.title3).lineLimit(1)
//        }.padding(.all, 10)
//        .foregroundColor(isSelected ? .white : .blue)
//        .background(isSelected ? Color.blue : Color.white)
//        .cornerRadius(40)
//        .overlay(
//                RoundedRectangle(cornerRadius: 40)
//                    .stroke(Color.blue, lineWidth: 1.5)
//
//        ).onTapGesture {
//            isSelected.toggle()
//        }
//    }
//}

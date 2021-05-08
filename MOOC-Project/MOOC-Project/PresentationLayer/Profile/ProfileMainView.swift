//
//  ProfileMainView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 07.05.2021.
//

import SwiftUI

struct ProfileMainView: View {
    @State var model: ProfileModel = ProfileModel()
    @Binding var isLoading: Bool
    var body: some View {
        ScrollView {
            TopView(isLoading: $isLoading,
                    model: $model)
                Spacer()
            MiddleView(showLoading: $isLoading,
                       model: $model)
        }
    }
}

struct ProfileMainView_Previews: PreviewProvider {
    @State static var isLoading: Bool = false
    static var previews: some View {
        ProfileMainView(isLoading: $isLoading)
    }
}

struct TopView: View {
    @Binding var isLoading: Bool
    @Binding var model: ProfileModel
    var body: some View {
        VStack {
            Text("Профиль")
                .underline()
                .fontWeight(.bold)
                .font(.title)
            Divider()
            HStack {
                VStack {
                    RemoteImage(url: "https://sun9-5.userapi.com/impg/EJvrEdq_H8E2dff_VgmkvYo14WFqSQH_72uLWQ/Ts9dzI_epLU.jpg?size=960x539&quality=96&sign=d91cd7a784b0370e2d76e375fd929c23&type=album")
                        .clipShape(Circle())
                        .centerCropped()
                        .frame(width: 90, height: 80, alignment: .center)
                    Button(action: {
                        isLoading.toggle()
                        RootAssembly.serviceAssembly.networkService.logOut {
                            isLoading.toggle()
                        }
                    }, label: {
                        Text("Выйти")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding(.all, 10)
                            .background(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 2))
                    })
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Логин: ")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(model.getUserInformation().login)
                    }
                    
                    HStack {
                        Text("Почта: ")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(model.getUserInformation().email)
                    }
                }
            }
            .padding(.all, 15)
            Divider()
        }
    }
}

struct MiddleView: View {
    @State var favorites: [CourseParsedShortDataModel] = []
    @State var viewed: [CourseParsedShortDataModel] = []
    @State var searchModel = SearchModel()
    
    @State var showFavorites: Bool = false
    @State var showViewed: Bool = false
    @Binding var showLoading: Bool
    
    @Binding var model: ProfileModel
    var body: some View {
        VStack(alignment: .leading) {
            
            Button(action: {
                withAnimation {
                    showFavorites.toggle()
                    showLoading.toggle()
                }
                    model.getFavoriteCourses { array, error in
                        guard let array = array else {
                            // TODO. alert
                            return
                        }
                        favorites = array
                        withAnimation {
                            showLoading.toggle()
                        }
                }
            }, label: {
                HStack {
                    if showFavorites {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    } else {
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    Text("Любимые курсы")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                Spacer()
            })
            
            if showFavorites {
                ForEach(favorites) { cell in
                    NavigationLink(destination: Preview(model: $searchModel, id: cell.id)) {
                        SearchTableItemView(data: cell)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                    }
                }
            }
            Button(action: {
                withAnimation {
                    showViewed.toggle()
                    showLoading.toggle()
                    model.getViewedCourses { array, error in
                        guard let array = array else {
                            // TODO. array
                            return
                        }
                        viewed = array
                        showLoading.toggle()
                    }
                }
            }, label: {
                HStack {
                    if showViewed {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    } else {
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    Text("Отложенные курсы")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                Spacer()
            })
            if showViewed {
                ForEach(viewed) { cell in
                    NavigationLink(destination: Preview(model: $searchModel, id: cell.id)) {
                        SearchTableItemView(data: cell)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 5)
    }
}

//
//  ContentView.swift
//  CustomCalendar
//
//  Created by Danilo Requena on 18/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var date = Date()
    @State var data: DateType!
    @State var expand = false
    @State var year = false
    
    var body: some View {
        GeometryReader{_ in
            
            VStack{
                if self.data != nil {
                    ZStack{
                        VStack(spacing: 15 ){
                            ZStack{
                                
                                HStack{
                                    Spacer()
                                    Text(self.data.Mounth)
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.vertical)
                                
                                HStack{
                                    Button(action: {
                                        
                                        self.date = Calendar.current.date(byAdding: .month, value: -1, to: self.date)!
                                        
                                        self.UpdateDate()
                                        
                                    }) {
                                        Image(systemName: "arrow.left")
                                            
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.date = Calendar.current.date(byAdding: .month, value: 1, to: self.date)!
                                        
                                        self.UpdateDate()
                                    }) {
                                        Image(systemName: "arrow.right")
                                        
                                            
                                    }
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                            }
                            .background(Color.red)
                            
                            Text(self.data.Date)
                                .font(.system(size: 65))
                                .fontWeight(.bold)
                            
                            Text(self.data.Day)
                            .font(.title)
                            
                            Divider()
                            
                            ZStack{

                                Text(self.data.Year)
                                    .font(.title)

                                HStack{
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation(.default) {
                                            self.expand.toggle()
                                        }
                                    }) {
                                        Image("arrow")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 10, height: 16)
                                            .rotationEffect(.init(degrees: self.expand ? 270 : 90 ))
                                    }
                                    .padding(.trailing, 30)
                                }
                                
                            }
                            
                            if self.expand {
                                Toggle(isOn: self.$year) {
                                    
                                    Text("Year")
                                        .font(.title)
                                }
                                .padding(.trailing, 15)
                                .padding(.leading, 25)
                            }
                        }
                        .padding(.bottom, self.expand ? 15 : 12)
                        
                        HStack{
                            Button(action: {
                                self.date = Calendar.current.date(byAdding: self.year ? .year : .day, value: -1, to: self.date)!
                                self.UpdateDate()
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)

                            }

                            Spacer()

                            Button(action: {
                                self.date = Calendar.current.date(byAdding: self.year ? .year : .day, value: 1, to: self.date)!
                                self.UpdateDate()
                            }) {
                                Image(systemName: "arrow.right")
                                .foregroundColor(.black)

                            }
                        }
                        .padding(.horizontal,30)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background(Color.white)
                    .cornerRadius(15)
                }
            }
        }
        .background(Color.black.opacity(0.06))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-YYYY"
            print(formatter.string(from: self.date))
        }
        .onAppear{
            self.UpdateDate()
        }
    }
    
    func UpdateDate() {
        let current = Calendar.current
        let date = current.component(.day, from: self.date)
        let mounthNO = current.component(.month, from: self.date)
        let month = current.monthSymbols[mounthNO - 1]
        let year = current.component(.year, from: self.date)
        let weekNO = current.component(.weekday, from: self.date)
        let day = current.weekdaySymbols[weekNO - 1]
        
        self.data = DateType(Day: "\(day)", Date: "\(date)", Year: "\(year)", Mounth: month)
    }
    
    struct DateType {
        var Day: String
        var Date: String
        var Year: String
        var Mounth: String
    }
}

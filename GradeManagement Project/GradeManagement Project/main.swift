//
//  main.swift
//  GradeManagement Project
//
//  Created by StudentPM on 1/22/25.
//

import Foundation
import CSV

//These arrays containing every student's names, scores, and final scores
var names: [String] = []
var finalScores: [Double] = []
var studentScores: [[String]] = []

var studentsInClass: Double = 38



do{
    let stream = InputStream(fileAtPath:"/Users/studentpm/Desktop/grade.csv")
    let csv = try CSVReader(stream: stream!)
    
    while let row = csv.next(){
        handleData(data: row)
    }
}
catch{
    print("There was an error trying to read the file!")
}


mainMenu()


// This is the grade manager's main menu, enter a number to perform a specific function
func mainMenu(){
    print("Welcome to the Grade Manager!")
    print("What would you like to do? (Enter the number):")
    print("1. Display grade of a single student")
    print("2. Display all grades for a student")
    print("3. Display all grades of ALL students")
    print("4. Find the average grade of the class")
    print("5. Find the average grade of an assignment")
    print("6. Find the lowest grade in the class")
    print("7. Find the highest grade of the class")
    print("8. Filter students by grade range")
    print("9. Quit")
    
    if let userInput = readLine(), let number = Int(userInput), number > 0, number < 10{
        if number == 1{
            displaySingleStudentGrade()
        }
        if number == 2{
            displayAllSingleStudentGrades()
        }
        if number == 3{
            displayAllStudentsGrades()
        }
        if number == 4{
            averageGradeOfClass()
        }
        if number == 5{
            averageAssignmentGrade()
        }
        if number == 6{
            lowestGradeInClass()
        }
        if number == 7{
            highestGradeInClass()
        }
        if number == 8{
            filterByGradeRange()
        }
        if number == 9{
            quitProgram()
        }
    }
    else{
        print("Enter a valid number!")
        mainMenu()
    }
}

func handleData(data: [String]){
    var tempScores: [String] = []
    
    for i in data.indices{
        if i == 0{
            names.append(data[i])
        }
        else{
            tempScores.append(data[i])
        }
    }
    
    studentScores.append(tempScores)
    
    var sum: Double = 0
    
    for score in tempScores{
        if let num = Double(score){
            sum += num
        }
    }
    
    let finalGrade: Double = sum/Double(tempScores.count)
    finalScores.append(finalGrade)
}

// This function displays a student's average grade in class
func displaySingleStudentGrade(){
    print("Which student would you like to choose?")
    
    if let userInput = readLine(){
        for i in names.indices{
            if userInput == names[i]{
                print("\(userInput)'s grade for this class is \(round(100.0 * finalScores[i])/100.0)")
            }
        }
        
        mainMenu()
    }
    else{
        print("Enter valid student name!")
        mainMenu()
    }
}

// This function displays all a student's grades after entering their name
func displayAllSingleStudentGrades(){
    print("Which student would you like to choose?")
    var studentPos: Int = 0;
    
    if let userInput = readLine(){
        for i in names.indices{
            if userInput == names[i]{
                studentPos = i
            }
        }
        
        print("\(names[studentPos])'s grades for this class are: ", terminator: "")
        for score in studentScores[studentPos]{
            print("\(score) ", terminator: "")
        }
        print("")
        mainMenu()
    }
}

// This function displays every student's grades
func displayAllStudentsGrades(){
    for i in studentScores.indices{
        print("\(names[i])'s scores are: ", terminator: "")
        for score in studentScores[i]{
            print("\(score) ", terminator: "")
        }
        print()
    }
    mainMenu()
}

// This function displays the average grade of the class
func averageGradeOfClass(){
    var sumOfGrades: Double = 0
    var averageGrade: Double = 0
    
    for i in finalScores.indices{
        sumOfGrades += finalScores[i]
    }
    
    averageGrade = round(100.0 * (sumOfGrades/studentsInClass))/100.0
    
    print("The average grade of this class is \(averageGrade)")
    
    mainMenu()
}

// This function finds the average grade of an assignment you choose
func averageAssignmentGrade(){
    var sumOfAssignments: Int = 0
    print("Which assignment would you like to get the average of (enter a number 0-9):")
        
    if let userInput = readLine(), let number = Int(userInput), number < 10{
        for i in studentScores.indices{
            if let score = Int(studentScores[i][number]){
                sumOfAssignments += score
            }
        }
        
        print("The average for assignment \(number + 1)# is \(round(100.0 * (Double(sumOfAssignments)/studentsInClass))/100.0)")
        mainMenu()
    }
    else{
        print("Enter a valid number!")
        mainMenu()
    }
}

// This function shows the lowest grade in the class
func lowestGradeInClass(){
    for i in finalScores.indices{
        if finalScores.min() == finalScores[i]{
            print("\(names[i]) is the student with the lowest grade: \(finalScores[i])")
            
            mainMenu()
        }
    }
}

// This function shows the highest grade in the class
func highestGradeInClass(){
    for i in finalScores.indices{
        if finalScores.max() == finalScores[i]{
            print("\(names[i]) is the student with the highest grade: \(finalScores[i])")
            
            mainMenu()
        }
    }
}

// This function lets you pick a low and high range, and view the all the student's grades within that range
func filterByGradeRange(){
    print("Enter the low range you would like to use:")
    
    if let lowNumber = readLine(), let lowerNum = Double(lowNumber), lowerNum < 100, lowerNum > -1{
        
        print("Enter the high range you would like to use:")
        if let highNumber = readLine(), let higherNum = Double(highNumber), higherNum > lowerNum, higherNum < 101{
            
            for i in finalScores.indices{
                if finalScores[i] >= lowerNum, finalScores[i] <= higherNum{
                    print("\(names[i]): \(finalScores[i])")
                }
            }
            
            mainMenu()
        }
        else{
            print("Enter a number higher than the low range or enter a number equal or less than 100")
            mainMenu()
        }
    }
    else{
        print("Enter a number less than 100 or greater than -1!")
        mainMenu()
    }
}

// This is to just quit the program
func quitProgram(){
    print("Goodbye! Have a good day!")
}

# AmusementParkPassGenerator

For this project, you are being asked to create a system for creating and validating access passes to an amusement park. Broadly speaking, there are three types of people who can be granted access to the park: employees, vendors and of course, guests. As you can imagine, these different groups are entitled to enter different areas of the park and may or not be permitted to do certain things, like: ride the rides or receive discounts in certain eateries and shops. In addition, within the category of employees, there are several types with varying access. Similarly, guests can either be “classic”, “vip”, or “free child”, and have differing privileges. Details on exactly what each type of entrant is permitted to do and what type of personal information is required from each, are spelled out in the Business Rules Matrix, linked in Project Resources.

This project is divided into two parts. The first part, outlined here, will focus on building the data structures, logic, error handling and other plumbing for this app. No user interface will be built for Part I of this project. Your code will be built, tested and run by using temporary hard-coded “plug” values.

For part two, which will be Project 5 of the iOS TechDegree, you will be constructing the User Interface Elements and flow, as shown in the project mockups and Onward and Upward Instruction Video. As part of this process, you will add features like user entry of data, look and feel and card generation. In addition, several additional types of entrants such as contracted employees, vendors, season pass holders and senior guests, will be added in Part II. Be sure to write your code for Part I such that it can be reused and extended in Part II. (You will probably need to refactor some code, regardless, but do keep this in mind.)

In crafting your code, be sure to make use of optionals, enums, protocols, data structures and error handling. Also, remember that you can use a combination of both inheritance and composition, depending on which is best suited for the particular feature. The majority of the tools, syntax and concepts needed to complete Part I have been covered in the courses so far, however implementing certain elements, like dates and extra credit items will require you to seek additional resources and documentation.

Just to be clear, the app you are creating would be utilized by the staff of the amusement park at the entrance gates, inside their kiosk. Actual entrants wouldn’t see the screen, but rather would tell the staff their relevant information and staff members would type it on the screen, generate passes and then test access levels. This app will not actually print any passes, but rather simply creates an image of the pass, as per the mockups.

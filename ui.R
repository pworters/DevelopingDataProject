library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Guess some metrics about babies!"),
        sidebarPanel(
                h3('Input your guesses'),
                sliderInput('weight', 'Guess at the mean birth weight', value=120, min=60, max=180, step=2,),
                h4('Your birth weight MSE is'),
                verbatimTextOutput("weightError"),
                sliderInput('gestation', 'Guess at the mean gestation period', value=250, min=150, max=350, step=5,),
                h4('Your gestation period MSE is'),
                verbatimTextOutput("gestationError")
        ),
        mainPanel(
                h3('Data from UsingR:babies'),
                ('Data are part of the Child Health and Development Studies (CHDS) — a comprehensive investigation of all pregnancies that occurred between 1960 and 1967 among women in the Kaiser Foundation Health Plan in the San Francisco East Bay area'),
                plotOutput('newFig')
        )
))
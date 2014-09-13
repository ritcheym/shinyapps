library(shiny)

# Note: to post to shinyapps, run: library('shinyapps'), deployApp('SimpleROC/')

# Define UI for application that draws an ROC
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Simple ROC Demo"),
  
  # Description
  fluidRow(
    column(6,
           p("This Shiny app demonstrates key concepts in signal detection and the
             influence of key parameters on receiver operating characteristic (ROC) curves. 
             Interested in memory? Visit the",
             a(href="http://maureen.shinyapps.io/DualProcessROC", "Dual Process ROC Demo.")
           )
    )
  ), 
  
  # Slider input for dprime, criterion, and target SD
  h4('Parameters'),
  
  sliderInput("dprime",
              "Discriminability (d'):",
              min = 0,
              max = 4,
              value = 2,
              step = .25),
  sliderInput("criterion",
              "Decision criterion (x):",
              min = -5,
              max = 5,
              value = 0,
              step = .5),
  sliderInput("targetsd",
              "Relative SD of target distribution (1 for equal variance):",
              min = .25,
              max = 3,
              value = 1,
              step = .25),
  
  hr(),
  
  # Text summary
  fluidRow(
           h4('Summary'),
           verbatimTextOutput("textTarget"),
           verbatimTextOutput("textLure")
  ),
  
  hr(),
  
  # Plots
  fluidRow(
    column(4,
           h4('Density functions'),
           plotOutput("distPlot")
    ),
    column(4,
           h4('ROC'),
           plotOutput("rocPlot")
    ),
    column(4,
           h4('zROC'),
           plotOutput("zrocPlot")
    )
  )
))
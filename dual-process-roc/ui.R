library(shiny)

# Note: to post to shinyapps, run: library('shinyapps'), deployApp('DualProcessROC/')

# Define UI for application that draws an ROC
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Dual Process ROC Demo"),
  
  # Description
  fluidRow(
    column(6,
           p("This Shiny app demonstrates the dual process model of recognition memory
             (Yonelinas, 1994) and the influence of familiarity and recollection on
             receiver operating characteristic (ROC) curves. 
             For a demo of the basic signal detection model, visit the",
             a(href="http://maureen.shinyapps.io/SimpleROC", "Simple ROC Demo.")
           )
    )
  ), 
  
  # Slider input for dprime, recollection, and criterion
  h4('Parameters'),
  
  sliderInput("dprime",
              "Familiarity (d'):",
              min = 0,
              max = 4,
              value = 2,
              step = .25),
  sliderInput("recollection",
              "Recollection:",
              min = 0,
              max = 1,
              value = .2,
              step = .1),
  sliderInput("criterion",
              "Decision criterion (x):",
              min = -5,
              max = 5,
              value = 0,
              step = .5),
  
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
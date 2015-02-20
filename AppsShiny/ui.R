library(shiny)
library (markdown)
# ui.R

shinyUI(fluidPage(
        titlePanel("Body Mass Index (BMI), Body Fat Percentaje (BFP)
                   and ideal weight"),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("Complete your personal data"),
                        
                        numericInput("age", 
                                    label = "Type your age in years",
                                    value = 0),
                        
                        selectInput("sex", label = "Select your gender", 
                                    choices = list("Male" = 0, "Female" = 1),
                                    selected = 1),
                        
                        numericInput("height", 
                                     label = "Type your height in meters",
                                     value = 0),
                        
                        helpText ("Note: e.g. if your height is 1 meter and 80 
                                  centimeters, you must type 1.80"),
                        
                        sliderInput("weight", 
                                    label = "Select your weight in Kg.",
                                    min = 30, max = 120, value = 65)
                        ),
                
                mainPanel(
                      tabsetPanel(
                            tabPanel ("Instructions", 
                                      includeMarkdown("text.md")),
                            
                            tabPanel ("Results",
                                      textOutput("text1"),
                                      
                                      plotOutput ("PlotBMI"),
                                      br(),
                                      br(),
                                      textOutput ("text2"),
                                      
                                      plotOutput ("PlotBFP"))
                            )
                        
                )
        )
))
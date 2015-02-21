library(shiny)
library (markdown) # for insert a markdown file, the "instructions" section
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
                        #Helping to put the height in m. appropriately
                        helpText ("Note: e.g. if your height is 1 meter and 80 
                                  centimeters, you must type 1.80"),
                        
                        sliderInput("weight", 
                                    label = "Select your weight in Kg.",
                                    min = 30, max = 120, value = 65)
                        ),
                
                mainPanel(
                      tabsetPanel(
                            #The instructions are in a markdown document.
                            tabPanel ("Instructions", 
                                      includeMarkdown("text.md")),
                            
                            tabPanel ("Results",
                                   #The BMI in a text form.
                                      textOutput("text1"),
                                      
                                      plotOutput ("PlotBMI"),
                                      br(),
                                      br(),
                                   #The BFP in a text form.
                                      textOutput ("text2"),
                                      
                                      plotOutput ("PlotBFP"))
                            )
                        
                )
        )
))
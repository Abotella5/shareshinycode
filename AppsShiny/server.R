# server.R

library (Hmisc)
Vec <- seq (from = 0, to = 50, by = 0.1)
points <- c (18.5, 25, 30, 35, 40)
dat <- data.frame (Vec = Vec)
dat$category <- cut2 (dat$Vec, points)
dat$category <- factor (dat$category, labels= c("Underweight", "Normal weight",
                                                "Pre-obesity", "Obesity class I",
                                                "Obesity class II", 
                                                "Obesity class III"))
pointsMale <- c (5, 20, 25)
dat$categoryMal <- cut2 (dat$Vec, pointsMale)
dat$categoryMal <- factor (dat$categoryMal, labels= c("Underweight", "Normal weight",
                                                "Overweight", "Obesity"))

pointsFemale <- c (5, 30, 35)
dat$categoryFem <- cut2 (dat$Vec, pointsFemale)
dat$categoryFem <- factor (dat$categoryFem, labels= c("Underweight", "Normal weight",
                                                      "Overweight", "Obesity"))


shinyServer(function(input, output) {
        
        BMIO <- reactive({
                round ((input$weight)/(input$height)^2, 1)  
        })
        
        BFPO <- reactive({
                sex <- as.numeric (input$sex)
                round ((-44.988)+(0.503*input$age)+(10.689*sex)+(3.172*BMIO())
                -(0.026*BMIO()^2)+(0.181*BMIO()*sex)-(0.02*BMIO()*input$age)
                -(0.005*BMIO()^2*sex)+(0.00021*BMIO()^2*input$age), 1)
        })
        
        
        output$text1 <- renderText({ 
                paste ("Your BMI is:", BMIO())

        })

        
        output$PlotBMI <- renderPlot({
                barplot(as.matrix(table(dat$category)), 
                        col= c("lightblue", "lightyellow", "lightgreen", "lightsalmon",
                               "lightpink","lightcoral"), 
                        beside = FALSE, axes = FALSE, 
                        main="Your Nutritional Status by BMI", ylab = "BMI")
                axis(side = 2, at = c(0, 100, 200, 300, 400, 500), 
                     labels = c("0", "10", "", "30", "", "50"))
                text (x=0.7, y=100, "Underweight")
                text (x=0.7, y=220, "Normal weight")
                text (x=0.7, y=275, "Pre-obesity")
                text (x=0.7, y=325, "Obesity class I")
                text (x=0.7, y=375, "Obesity class II")
                text (x=0.7, y=450, "Obesity class III")
                
                abline (h=BMIO()*10, col="red", lwd=2)
        })
        
        
        output$text2 <- renderText({
                paste ("Your BFP is:", BFPO())
        })
        
        output$PlotBFP <- renderPlot({
                if (input$sex==0) {
                        barplot(as.matrix(table(dat$categoryMal)), 
                                col= c("lightyellow", "lightgreen", "lightsalmon", "lightcoral"), 
                                beside = FALSE, axes = FALSE, 
                                main="Your Nutritional Status by BFP (MALES)", ylab = "BFP")
                        axis(side = 2, at = c(0, 100, 200, 300, 400, 500), 
                             labels = c("0", "10", "20", "30", "40", "50"))
                        text (x=0.7, y=25, "Underweight")
                        text (x=0.7, y=130, "Normal weight")
                        text (x=0.7, y=225, "Overweight")
                        text (x=0.7, y=335, "Obesity")
                } else {
                        barplot(as.matrix(table(dat$categoryFem)), 
                                col= c("lightyellow", "lightgreen", "lightsalmon", "lightcoral"), 
                                beside = FALSE, axes = FALSE, 
                                main="Your Nutritional Status by BFP (FEMALES)", ylab = "BFP")
                        axis(side = 2, at = c(0, 100, 200, 300, 400, 500), 
                             labels = c("0", "10", "20", "30", "40", "50"))
                        text (x=0.7, y=25, "Underweight")
                        text (x=0.7, y=180, "Normal weight")
                        text (x=0.7, y=330, "Overweight")
                        text (x=0.7, y=445, "Obesity")
                }
                
                abline (h=BFPO()*10, col="red", lwd=2)   
        })
        
}
)
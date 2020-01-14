#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    iris_mod <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species, data = iris)
    
    pred_val <- reactive({
        sepWidth_input <- input$sep_wid
        PetLen_input <- input$pet_len
        PetWidth_input <- input$pet_wid
        spec_input <- switch(input$spec_choice,
                             "Setosa" = 'setosa', 
                             "Versicolor" = 'versicolor', 
                             "Virginica" = 'virginica')
        predict(iris_mod, newdata = data.frame(Sepal.Width = sepWidth_input,
                                               Petal.Length = PetLen_input,
                                               Petal.Width = PetWidth_input,
                                               Species = spec_input))
    })
    
    
    
    output$sep_len <- renderText({
        sepLen_pred <- round(pred_val(),1)
        paste('Predicted Sepal Length = ', sepLen_pred)
    })
  
    
    output$iris_plot <- renderPlot({
        input_val <- ifelse(input$plot_choice == 'Sepal Width', input$sep_wid,
                            ifelse(input$plot_choice == 'Petal Length', input$pet_len, input$pet_wid))
        spec_input <- switch(input$spec_choice,
                             "Setosa" = 'setosa', 
                             "Versicolor" = 'versicolor', 
                             "Virginica" = 'virginica')
        plot_by <- switch(input$plot_choice,
                          'Sepal Width' = iris$Sepal.Width,
                          'Petal Length' = iris$Petal.Length,
                          'Petal Width' = iris$Petal.Width)
        
        ggplot(iris, aes(plot_by, Sepal.Length, color = Species)) +
            geom_point(size = 2) +
            ylab('Sepal Length') + xlab(input$plot_choice) + 
            #xlim(c(0,10)) + ylim(c(0,15)) +
            scale_colour_manual(breaks=c("setosa", "versicolor", "virginica"),
                                labels=c("Setosa", "Versicolor", "Virginica"),
                                values = c('#F8766D', '#00BFC4', '#C77CFF')) +
            theme_bw() +
            theme(panel.grid.major = element_blank(),
                  panel.grid.minor = element_blank()) +
            geom_point(aes(x = input_val, y = pred_val()), colour="black", size = 2)
        
    })

})



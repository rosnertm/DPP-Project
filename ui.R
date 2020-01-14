#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Iris Prediction App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            helpText('This app uses the iris data set to predict sepal length based on sepal width,
                     petal length, petal width, and species chosen. Note that the "Go!" button must
                     be clicked in order to see any changes.'),
            h4('Prediction Variables'),
            h5('Changing these values will change the predicted sepal length'),
            numericInput("sep_wid",
                        "Sepal Width:",
                        min = 1,
                        max = 10,
                        step = .1,
                        value = 3.5),
            numericInput("pet_len",
                         "Petal Length:",
                         min = 1,
                         max = 10,
                         step = .1,
                         value = 1.4),
            numericInput("pet_wid",
                         "Petal Width:",
                         min = .1,
                         max = 5,
                         step = .1,
                         value = .2),
            radioButtons("spec_choice",
                         "Choose the species",
                         choices = c("Setosa", "Versicolor", "Virginica"),
                         selected = 'Setosa'),
            br(),
            h4('Plot Variable'),
            h5('Changing this value will change the plot.'),
            radioButtons('plot_choice',
                         'Choose the X Axis Variable',
                         choices = c('Sepal Width',
                                     'Petal Length',
                                     'Petal Width'),
                         selected = 'Sepal Width'),
            submitButton('Go!')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3(textOutput("sep_len")),
            h4('Prediction shown in black on plot'),
            plotOutput('iris_plot')
        )
    )
))

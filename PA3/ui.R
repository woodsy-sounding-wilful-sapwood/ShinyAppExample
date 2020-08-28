#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Demonstration of the Central Limit Theorem"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("n.var",
                        "Number of Variables:",
                        min = 1,
                        max = 80,
                        value = 40),
            sliderInput("n.sim",
                        "Number of Iterations:",
                        min = 1,
                        max = 2000,
                        value = 1000),
            sliderInput("lambda",
                        "Rate of the Exponential Distribution:",
                        min = 0.01,
                        max = 2,
                        value = 0.2,
                        step = 0.01),
            textOutput("doc")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
        
        n.sim <- input[["n.sim"]]
        n.var <- input[["n.var"]]
        lambda <- input[["lambda"]]

        x.raw <- matrix(rexp(n.sim*n.var, rate = lambda), nrow = n.var, ncol = n.sim)
        x <- data.frame(x.raw)
        
        sample_means <- data.frame(means = x %>% summarise_all(mean) %>% unlist(., use.names = FALSE))
        theoretical_mean <- 1/lambda
        g1 <- ggplot(sample_means, aes(x=means)) + geom_histogram(bins = 20, fill="lightgoldenrod", color="goldenrod") + geom_vline(xintercept = theoretical_mean, color = "steelblue") + xlab("Sample Mean") + ylab("Count") + labs(title = "Distribution of the Sample Means") + geom_text(aes(x = theoretical_mean, y = 0, label  = "Theoretical Mean"), size=3, angle=90, vjust=-0.4, hjust=0)
        g1

    })
    
    output$doc <- renderText({
        n.sim <- input[["n.sim"]]
        n.var <- input[["n.var"]]
        lambda <- input[["lambda"]]
        
        paste("This app will take", n.var,
              "samples from an Exponential Distribution with lambda =",
              lambda,
              "and compute the sample mean.",
              "It will do this",
              n.sim,
              "times and plot the distribution of sample means on the right. Along with a line representing the theoretical sample mean.",
              "Note that this histogram converges to a normal distribution as we increase the number of samples and the number of iterations"
        )
    })

})

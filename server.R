library(shiny)
library(UsingR)
data(babies)
babies[babies==999] <- NA
meanGestation <- mean(babies$gestation, na.rm = TRUE)
meanWt <- mean(babies$wt)

shinyServer(
        function(input, output) {
                output$newFig <- renderPlot({                        
                        myFig <- plot(babies$wt, babies$gestation, main = "Gestation period versus weight of babies at birth", ylab = "Gestation period (days)", xlab = "Birth weight (oz)")
                        figLims <- data.frame(par("usr"))
                        
                        # Plot user inputs
                        vLine <- input$weight
                        lines(c(vLine, vLine), c(figLims[3,1], figLims[4,1]), col="red", lwd=5)                        
                        hLine <- input$gestation
                        lines(c(figLims[1,1], figLims[2,1]), c(hLine, hLine), col="blue", lwd=5)
                        
                        # Calculate errors
                        gestationMse <- mean((meanGestation-input$gestation)^2)
                        output$gestationError <- renderPrint({gestationMse})
                        weightMse <- mean((meanWt-input$weight)^2)
                        output$weightError <- renderPrint({weightMse})
                        
                        flag <- ((gestationMse + weightMse) < 1.0)
                        
                        if (flag) {
                                output$status <- renderPrint({'SUCCESS'})
                        } else {
                                output$status <- renderPrint({"TRY AGAIN"})
                        }
                })
        }
)
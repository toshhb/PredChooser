# server.R
require(shiny)
require(datasets)

data(mtcars)

shinyServer(function(input, output) {
    
    # precompute some objects that are shared by later commands
    formulaText <- reactive({
        if (length(input$checkGroup) == 0)
            return("mpg~.")
        predictors = paste0(input$checkGroup, collapse="+")
        paste0("mpg~", predictors)
    })
    
    fitCommand <- reactive({
        command = paste0("lm(", formulaText(), ", data=mtcars)")
    })
    
    fit <- reactive({
        eval(parse(text = fitCommand()))
    })
    
    # outputs
    output$formula <- renderText({ 
        paste0("lm(", formulaText(),", data=mtcars)")
    })
    
    output$summary <- renderPrint({
        summary(fit())
    })
    
    output$anova <- renderTable({ 
        anova(lm(as.formula(formulaText()), data=mtcars))
    })

    output$plot <- renderPlot({
        predictions = predict(fit())
        par(mfrow=c(2,1), mar=c(1.2,5,3,2))
        plot(fit()$residuals[order(mtcars$mpg)], col="red", type="s",
                        main=paste("residuals of", fitCommand()),
                        xlab="", ylab="residuals (sorted)")
        abline(0,0)

        with(mtcars, plot(mpg[order(mpg)], main="mpg vs. predicted mpg", 
                          xlab="", ylab="mpg (sorted)"))
        points(predictions[order(mtcars$mpg)], col="red")
        legend('bottomright', c('mpg','predictions'), pch=1, col=c('black','red'), bty='n', cex=.75)
    })

#     output$plot <- renderPlot({
#         with(fit(),plot(residuals, type="l", col="red", main=paste("residuals of", fitCommand())))
#         abline(0,0)
#     })

})
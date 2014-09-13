library(shiny)

# Define server logic required to draw an ROC
shinyServer(function(input, output) {
  
  lure <- seq(-5,10,length=1000)
  target <- seq(-5,10,length=1000)
  
  output$distPlot <- renderPlot({
    # get normal probability density functions
    dlure <- dnorm(lure,mean=0,sd=1)
    dtarget <- dnorm(target,mean=input$dprime,sd=input$targetsd) # sd=1 for equal variance SD
    
    # draw the density function + line for criterion
    plot(lure, dlure, type="l", col='blue', xlab="", ylab="", ylim=c(0,.5)) # lure distribution
    par(new=T)
    plot(target, dtarget, type="l", col='red', axes=F, xlab="x", ylab="Normal probability density function", ylim=c(0,.5)) # target distribution
    abline(v=input$criterion,lty=3) # dotted line for criterion
    legend("topright",legend=c("lure","target"),col=c("blue","red"),lty=1)
    par(new=F)
  },height=400,width=400)
  
  output$rocPlot <- renderPlot({
    # get response probabilities for each distribution
    plure <- 1-pnorm(lure,mean=0,sd=1)
    ptarget <- 1-pnorm(target,mean=input$dprime,sd=input$targetsd)
    
    # get response probabilities at criterion
    plure.crit <- 1-pnorm(input$criterion,mean=0,sd=1)
    ptarget.crit <- 1-pnorm(input$criterion,mean=input$dprime,sd=input$targetsd)
    
    # draw the ROC + dot for criterion + chance line
    plot(plure,ptarget, type="l", col='black', xlim=c(0,1), ylim=c(0,1), xlab="", ylab="")
    par(new=T)
    plot(plure.crit, ptarget.crit, col='black', pch=19, xlim=c(0,1), ylim=c(0,1), axes=F, , xlab="FA Rate", ylab="Hit Rate")
    abline(a=0,b=1,lty=3)
    par(new=F)
  },height=400,width=400)
  
  output$zrocPlot <- renderPlot({
    # get response probabilities for each distribution
    plure <- 1 - pnorm(lure,mean=0,sd=1)
    ptarget <- 1-pnorm(target,mean=input$dprime,sd=input$targetsd)
    qlure <- qnorm(plure[plure>.001 & plure<.999 & ptarget>.001 & ptarget<.999]) # drop endpoints (0 & 1 go to Inf)
    qtarget <- qnorm(ptarget[plure>.001 & plure<.999 & ptarget>.001 & ptarget<.999])
    
    # get response probabilities at criterion
    plure.crit <- 1 - pnorm(input$criterion,mean=0,sd=1)
    ptarget.crit <- 1-pnorm(input$criterion,mean=input$dprime,sd=input$targetsd)
    qlure.crit <- qnorm(plure.crit)
    qtarget.crit <- qnorm(ptarget.crit)
    
    # draw the zROC + dot for criterion
    plot(qlure,qtarget, type="l", col='black', xlim=c(-3.1,3.1), ylim=c(-3.1,3.1),xlab="z FA Rate", ylab="z Hit Rate")
    par(new=T)
    plot(qlure.crit, qtarget.crit, col='black', pch=19, xlim=c(-3.1,3.1), ylim=c(-3.1,3.1), axes=F, xlab="z FA Rate", ylab="z Hit Rate")
    abline(a=0,b=1,lty=3)
    par(new=F)
  },height=400,width=400)
  
  output$textTarget <- renderText({
    plure.crit <- 1-pnorm(input$criterion,mean=0,sd=1)  
    ptarget.crit <- 1-pnorm(input$criterion,mean=input$dprime,sd=input$targetsd)
    
    paste("Hit rate, or targets correctly identified: ",round(100*ptarget.crit,1),"%",sep="")
  })
  
  output$textLure <- renderText({
    plure.crit <- 1-pnorm(input$criterion,mean=0,sd=1)
    ptarget.crit <- 1-pnorm(input$criterion,mean=input$dprime,sd=input$targetsd)
    
    paste("False alarm rate, or lures incorrectly identified: ",round(100*plure.crit,1),"%",sep="")
  })
  
})
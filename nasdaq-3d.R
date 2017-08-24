library(plotly)
library(shiny)

ui <- fluidPage(
    plotlyOutput("plot"),
    verbatimTextOutput("hover"),
    verbatimTextOutput("click")
)

server <- function(input, output, session) {
    nasdaq <- read.csv("^IXIC.csv")
    
    f <- list(
        family = "Courier New, monospace",
        size = 20,
        color = "blue"
    )
    x <- list(
        title = "Date(x)",
        titlefont = f
    )
    y <- list(
        title = "Opening Price(y)",
        titlefont = f
    )
    z <- list(
        title = "Volume(z)"
    )
    
    output$plot <- renderPlotly({
        plot_ly(nasdaq, x = ~Date, y = ~Open, z = ~Volume, type = "scatter3d") %>%
            layout(titlefont=f, title = 'Nasdaq Opening Price and Volume since January 1, 2009')
        })
    
    output$hover <- renderPrint({
        d <- event_data("plotly_hover")
        if (is.null(d)) "Hover events appear here (unhover to clear)" else d
    })
    
    output$click <- renderPrint({
        d <- event_data("plotly_click")
        if (is.null(d)) "Click events appear here (double-click to clear)" else d
    })
    
}

shinyApp(ui, server)
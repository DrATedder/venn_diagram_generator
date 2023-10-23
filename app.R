# Load required libraries
library(shiny)
library(VennDiagram)
library(dplyr)
library(grid)
library(png)

# Define the UI
ui <- fluidPage(
  titlePanel("Venn Diagram Generator"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Select Data File 1"),
      fileInput("file2", "Select Data File 2"),
      fileInput("file3", "Select Data File 3"),
      
      selectInput("outputFormat", "Select Output Format", choices = c("PDF", "PNG")),
      textInput("outputFilename", "Output Filename", placeholder = "Enter Filename"),
      
      actionButton("generateVenn", "Generate Venn Diagram")
    ),
    
    mainPanel(
      plotOutput("vennPlot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  venn_plot_data <- eventReactive(input$generateVenn, {
    if (!is.null(input$file1) && !is.null(input$file2)) {
      venn_data <- list(
        unique(read.table(input$file1$datapath, header = FALSE, colClasses = "character")[, 1]),
        unique(read.table(input$file2$datapath, header = FALSE, colClasses = "character")[, 1])
      )
      
      if (!is.null(input$file3)) {
        venn_data[[3]] <- unique(read.table(input$file3$datapath, header = FALSE, colClasses = "character")[, 1])
      }
      
      group_names <- unique(c(
        substr(input$file1$name, 1, regexpr("_", input$file1$name) - 1),
        substr(input$file2$name, 1, regexpr("_", input$file2$name) - 1),
        if (!is.null(input$file3)) substr(input$file3$name, 1, regexpr("_", input$file3$name) - 1)
      ))
      
      venn_colors <- c("dodgerblue", "tomato", "darkorchid")
      
      return(venn.diagram(
        x = venn_data,
        category.names = group_names,
        filename = NULL,
        output = FALSE,
        category.col = venn_colors,
        lty = 2,  # Set the line type
        fill = venn_colors,  # Set the fill colors
        col = "black"  # Set the border color
      ))
    }
  })
  
  # Generate Venn diagram
  output$vennPlot <- renderPlot({
    grid.draw(venn_plot_data())
  })
  
  # Download Venn diagram
  observeEvent(input$generateVenn, {
    outputFilename <- paste0(input$outputFilename, ".", tolower(input$outputFormat))
    
    if (input$outputFormat == "PDF") {
      pdf(outputFilename, width = 8, height = 6)
      grid.draw(venn_plot_data())
      dev.off()
    } else if (input$outputFormat == "PNG") {
      png(outputFilename, width = 800, height = 600)
      grid.draw(venn_plot_data())
      dev.off()
    }
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)





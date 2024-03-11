library(shiny)
library(ggplot2)

# Defino los elementos UI
ui <- fluidPage(
  titlePanel("Gráfico de la Masa Monetaria"),
  
  # Creo mi slicer
  sidebarLayout(
    sidebarPanel(
      sliderInput("masa_monetaria",
                  "La Masa Monetaria:",
                  min = 100, max = 1000, value = 500)
    ),
    
    # Muestros los gráficos que he creado para el panel del simulador
    mainPanel(
      plotOutput("masa_monetaria_plot"),
      plotOutput("umbral_plot")
    )
  )
)

# Lógica del server
server <- function(input, output) {
  
  output$masa_monetaria_plot <- renderPlot({
    # Genero los valores de x que serán el nivel de impuestos.
    presion_fiscal <- seq(0, 1, length.out = 100)
    
    # Calculo la masa monetaria resultante
    masa_monetaria <- input$masa_monetaria
    y_values <- masa_monetaria * (1 - presion_fiscal)
    
    # dataframe de masa monetaria resultante
    df <- data.frame(presion_fiscal, y_values)
    
    # Gráfico de barras en ggplot para masa monetaria resultante
    ggplot(df, aes(x = presion_fiscal, y = y_values)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(x = "Presión Fiscal", y = "Resultado", 
           title = "Gráfico de la Masa Monetaria") +
      theme_minimal() +
      theme(axis.line = element_line(color = "black"),
            axis.text = element_text(color = "black"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank(),
            axis.title = element_text(size = 12),
            plot.title = element_text(size = 14, hjust = 0.5))
  })
  
  output$umbral_plot <- renderPlot({
    # Genero los valores de x que serán el nivel de impuestos
    thresholds <- seq(0, 1, length.out = 11)
    
    # Calculo masa monetaria necesaria para mantener el umbral anterior
    masa_umbral <- input$masa_monetaria / (1 - thresholds)
    
    # Gráfico de barras en ggplot para la masa monetaria necesaria
    df_umbral <- data.frame(umbral = thresholds, masa_umbral = masa_umbral)
    
    
    p <- ggplot(df_umbral, aes(x = factor(umbral), y = masa_umbral)) +
      geom_bar(stat = "identity", fill = "green") +
      labs(x = "Umbral (t)", y = "Masa Monetaria Necesaria", 
           title = "Masa Monetaria Necesaria en Cada Umbral de t") +
      theme_minimal() +
      theme(axis.line = element_line(color = "black"),
            axis.text = element_text(color = "black"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_blank(),
            axis.title = element_text(size = 12),
            plot.title = element_text(size = 14, hjust = 0.5)) +
      geom_text(aes(label = round(masa_umbral, 2)), vjust = -0.5, size = 3) # Add labels
    
   
    if(nrow(df_umbral) > 6) {
      p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1))
    }
    
    p
  })
}

# Corro la aplicación
shinyApp(ui = ui, server = server)

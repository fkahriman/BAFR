#
library(shiny)
library(BAFR)

## Veri Giris Modulu----------------------------------------------------------------
csvFileInput <- function(id, label = "CSV file") {
  # Create a namespace function using the provided id
  ns <- NS(id)

  tagList(
    fileInput(ns("file"), label)
  )
}

# Module server function
csvFile <- function(input, output, session, stringsAsFactors) {
  # The selected file, if any
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })

  # The user's data, parsed into a data frame
  dataframe <- reactive({
    read.table(userFile()$datapath,
             header = TRUE)
  })

  # We can run observers in here if we want to
  observe({
    msg <- sprintf("Dosya %s yuklendi", userFile()$name)
    cat(msg, "\n")
  })

  # Return the reactive that yields the data frame
  return(dataframe)
}

## Veri Giris Modulu----------------------------------------------------------------

# BAFR App
ui <- fluidPage(    # Application title
  titlePanel(img(src = "logo.png", height = 51, width = 151,
                 tags$head(
                   tags$style(HTML("
          .navbar .navbar-nav {float: right}
          .navbar .navbar-header {float: left}
        "))
))),
  navbarPage("BAFR",
             tabPanel("Hakkinda",
                      sidebarLayout(
                        sidebarPanel(
                          h2("Indirme"),
                          p("BAFR uygulamasi GitHub serveri Uzerinden indirilebilir bir pakete sahiptir:"),
                          code('devtools::install_github("fkahriman/BAFR")'),
                          br(),
                          br(),
                          br(),
                          br(),
                          img(src = "Rstudio.png", height = 75, width = 75),
                          img(src = "Shiny.png", height = 90, width = 75),
                          br(),
                          "BAFR uygulaması ",
                          span("RStudio", style = "color:blue"),"ve",span("Shiny", style = "color:blue"),"paketi kullanılarak geliştirilmiştir"
                        ),
                        mainPanel(
                          h1("BAFR Hakkında"),
                          p("BAFR yazılımı Shiny paketi kullanilarak RStudio platformunda gelistirilmis bir uygulamadır."),
                          br(),
                          p("Uygulamanin tasinabilir versiyonunu indirmek ve daha detaylı bilgi için lütfen",
                            a("BAF Elektronik Yazilim Tarim A.S. web sayfasini",
                              href = "www.baf-eyt.com.tr"), "ziyaret ediniz."),
                          br(),
                          p("Referans=>BAFR:Bitki Islahi Denemelerinin Analizinde Kullanilabilecek Turkce Arayuzlu R Uygulamasi."),
                          h2("Ozellikler"),
                          p("- Acik kaynak kodludur."),
                          p("- Kod yazmak gerektirmez."),
                          p("- Yaygin olarak kullanilan islah desenlerine iliskin modelleri vardir."),
                          p("- GNU lisanli bir uygulamadir."),
                          p("- Bilimsel calismalarda kullanilmak amaciyla gelistirilmistir."),
                          p("- BAFR uygulamasi agricolae, DiallelAnaylysisR paketlerindeki kodlardan yararlanmaktadir.")
                        )
                      )
             ),
## SIRA DIZI ANALIZI (Line x Tester)----------------------------------------------------------------

             tabPanel("Line Tester Analizi",
                      sidebarLayout(
                          # Sidebar panel for inputs ----
                          sidebarPanel(
                            csvFileInput("file1", "User data (.csv format)"),
                            actionButton("btn1", "Hesapla")),

                        mainPanel(
                          tabsetPanel(
                            tabPanel("Veri Girisi", tableOutput(outputId = "table1")),
                            tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results1"))
                          )
                        )
                      )),
## NORTH CAROLINA ANALIZLERI----------------------------------------------------------------
navbarMenu("North Carolina Analizleri",
           tabPanel("North Carolina-1",
                    sidebarLayout(

                      # Sidebar panel for inputs ----
                      sidebarPanel(
                        csvFileInput("file2", "User data (.csv format)"),
                        actionButton("btn2", "Hesapla")),

                      mainPanel(
                        tabsetPanel(
                          tabPanel("Veri Girisi", tableOutput(outputId = "table2")),
                          tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results2"))
                        )
                      )
                    )),
           tabPanel("North Carolina-2",
                    sidebarLayout(

                      # Sidebar panel for inputs ----
                      sidebarPanel(
                        csvFileInput("file3", "User data (.csv format)"),
                        actionButton("btn3", "Hesapla")),

                      mainPanel(
                        tabsetPanel(
                          tabPanel("Veri Girisi", tableOutput(outputId = "table32")),
                          tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results3"))
                        )
                      )
                    )),
           tabPanel("North Carolina-3",
                    sidebarLayout(

                      # Sidebar panel for inputs ----
                      sidebarPanel(
                        csvFileInput("file4", "User data (.csv format)"),
                        actionButton("btn4", "Hesapla")),

                      mainPanel(
                        tabsetPanel(
                          tabPanel("Veri Girisi", tableOutput(outputId = "table4")),
                          tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results4"))
                        )
                      )
                    ))),
## GRIFFING DIALLEL ANALIZLERI----------------------------------------------------------------
             navbarMenu("Griffing Diallel Analizleri",
                        tabPanel("Griffing Diallel Metot-1",
                                 sidebarLayout(

                                   # Sidebar panel for inputs ----
                                   sidebarPanel(
                                     csvFileInput("file5", "User data (.csv format)"),
                                     actionButton("btn5", "Model 1'e Göre Hesapla"),
                                     actionButton("btn6", "Model 2'ye Göre Hesapla")),

                                     mainPanel(
                                     tabsetPanel(
                                       tabPanel("Veri Girisi", tableOutput(outputId = "table5")),
                                       tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results5"))
                                     )
                                   ))),
                        tabPanel("Griffing Diallel Metot-2",
                                 sidebarLayout(

                                   # Sidebar panel for inputs ----
                                   sidebarPanel(
                                     csvFileInput("file6", "User data (.csv format)"),
                                     actionButton("btn7", "Model 1'e Göre Hesapla"),
                                     actionButton("btn8", "Model 2'ye Göre Hesapla")),

                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Veri Girisi", tableOutput(outputId = "table6")),
                                       tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results6"))
                                     )
                                   )
                                 )),
                        tabPanel("Griffing Diallel Metot-3",
                                 sidebarLayout(

                                   # Sidebar panel for inputs ----
                                   sidebarPanel(
                                     csvFileInput("file7", "User data (.csv format)"),
                                     actionButton("btn9", "Model 1'e Göre Hesapla"),
                                     actionButton("btn10", "Model 2'ye Göre Hesapla")),

                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Veri Girisi", tableOutput(outputId = "table7")),
                                       tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results7"))
                                     )
                                   )
                                 )),
                        tabPanel("Griffing Diallel Metot-4",
                                 sidebarLayout(

                                   # Sidebar panel for inputs ----
                                   sidebarPanel(
                                     csvFileInput("file8", "User data (.csv format)"),
                                     actionButton("btn11", "Model 1'e Göre Hesapla"),
                                     actionButton("btn12", "Model 2'ye Göre Hesapla")),

                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Veri Girisi", tableOutput(outputId = "table8")),
                                       tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results8"))
                                     )
                                   )
                                 ))),
## HAYMAN DIALLEL ANALIZLERI----------------------------------------------------------------
             tabPanel("Hayman Diallel Analizler",
                      sidebarLayout(

                        # Sidebar panel for inputs ----
                        sidebarPanel(
                          csvFileInput("file9", "User data (.csv format)"),

                          actionButton("btn13", "Hesapla"),
                          actionButton("btn14", "Grafik Oluştur")),

                        mainPanel(
                          tabsetPanel(
                            tabPanel("Veri Girisi", tableOutput(outputId = "table9")),
                            tabPanel("Analiz Sonucu", verbatimTextOutput(outputId = "Results9")),
                            tabPanel("Grafik", plotOutput(outputId = "plot9"))
                          )
                        )
                      ))
             ))

# Define server logic to read selected file ----
server <- function(input, output,session) {
    datafile1 <- callModule(csvFile, "file1",
                          stringsAsFactors = FALSE)
    datafile2 <- callModule(csvFile, "file2",
                         stringsAsFactors = FALSE)
    datafile3 <- callModule(csvFile, "file3",
                            stringsAsFactors = FALSE)
    datafile4 <- callModule(csvFile, "file4",
                            stringsAsFactors = FALSE)
    datafile5 <- callModule(csvFile, "file5",
                            stringsAsFactors = FALSE)
    datafile6 <- callModule(csvFile, "file6",
                            stringsAsFactors = FALSE)
    datafile7 <- callModule(csvFile, "file7",
                            stringsAsFactors = FALSE)
    datafile8 <- callModule(csvFile, "file8",
                            stringsAsFactors = FALSE)
    datafile9 <- callModule(csvFile, "file9",
                            stringsAsFactors = FALSE)

      output$table1 <- renderTable({
      datafile1()
   })

    output$table2 <- renderTable({
    datafile2()
  })

    output$table3 <- renderTable({
      datafile3()
    })

    output$table4 <- renderTable({
      datafile4()
    })

    output$table5 <- renderTable({
      datafile5()
    })

    output$table6 <- renderTable({
      datafile6()
    })

    output$table7 <- renderTable({
      datafile7()
    })

    output$table8 <- renderTable({
      datafile8()
    })

    output$table9 <- renderTable({
      datafile9()
    })

    observeEvent(input$btn1, {
      cat("Showing", input$file1, "rows\n")
    })

    op1 <- eventReactive(input$btn1, {
      LinexTest(datafile1())
    })

    output$Results1 <- renderPrint({
      op1()
    })

    observeEvent(input$btn2, {
      cat("Showing", input$file2, "rows\n")
    })

    op2 <- eventReactive(input$btn2, {
      NCM1(datafile2())
    })

    output$Results2 <- renderPrint({
      op2()
    })

    observeEvent(input$btn3, {
    cat("Showing", input$file3, "rows\n")
  })

  op32 <- eventReactive(input$btn3, {
    NCM2(datafile3())
  })

   output$Results3 <- renderPrint({
   op32()
  })

   observeEvent(input$btn4, {
     cat("Showing", input$file4, "rows\n")
   })

   op4 <- eventReactive(input$btn4, {
     NCM3(datafile4())
   })

   output$Results4 <- renderPrint({
     op4()
   })
   values <- reactiveValues(btn5=0, btn6=0, btn7=0, btn8=0, btn9=0, btn10=0, btn11=0, btn12=0)
   observeEvent(input$btn5, {
     cat("Showing", input$file5, "rows\n")
     values$btn5 <- 1
     values$btn6 <- 0
   })

   op5 <- eventReactive(input$btn5, {
     GriffingM1M1(datafile5())
   })

   observeEvent(input$btn6, {
     cat("Showing", input$file5, "rows\n")
     values$btn5 <- 0
     values$btn6 <- 1
   })

   op6 <- eventReactive(input$btn6, {
     GriffingM1M2(datafile5())
   })

   output$Results5 <- renderPrint({
     if(values$btn5)
       op5()
     else
     if(values$btn6)
       op6()
   })
   observeEvent(input$btn7, {
     cat("Showing", input$file5, "rows\n")
     values$btn7 <- 1
     values$btn8 <- 0
   })

   op7 <- eventReactive(input$btn7, {
     GriffingM2M1(datafile5())
   })

   observeEvent(input$btn8, {
     cat("Showing", input$file6, "rows\n")
     values$btn7 <- 0
     values$btn8 <- 1
   })

   op8 <- eventReactive(input$btn7, {
     GriffingM2M2(datafile5())
   })

   output$Results6 <- renderPrint({
     if(values$btn7)
       op7()
     else
       if(values$btn8)
         op8()
   })
   observeEvent(input$btn9, {
     cat("Showing", input$file5, "rows\n")
     values$btn9 <- 1
     values$btn10 <- 0
   })

   op9 <- eventReactive(input$btn9, {
     GriffingM3M1(datafile5())
   })

   observeEvent(input$btn10, {
     cat("Showing", input$file5, "rows\n")
     values$btn9 <- 0
     values$btn10 <- 1
   })

   op10 <- eventReactive(input$btn10, {
     GriffingM3M2(datafile5())
   })

   output$Results7 <- renderPrint({
     if(values$btn9)
       op9()
     else
       if(values$btn10)
         op10()
   })
   observeEvent(input$btn11, {
     cat("Showing", input$file5, "rows\n")
     values$btn11 <- 1
     values$btn12 <- 0
   })

   op11 <- eventReactive(input$btn11, {
     GriffingM4M1(datafile5())
   })

   observeEvent(input$btn12, {
     cat("Showing", input$file5, "rows\n")
     values$btn11 <- 0
     values$btn12 <- 1
   })

   op12 <- eventReactive(input$btn12, {
     GriffingM4M2(datafile5())
   })

   output$Results8 <- renderPrint({
     if(values$btn11)
       op11()
     else
       if(values$btn12)
         op12()
   })

   observeEvent(input$btn13, {
     cat("Showing", input$file9, "rows\n")
   })

   op13 <- eventReactive(input$btn13, {
     HaymanR(datafile9())
   })

   output$Results9 <- renderPrint({
     op13()
   })

      observeEvent(input$btn14, {
     cat("Showing", input$file9, "rows\n")
   })

   op14 <- eventReactive(input$btn14, {
     HaymanPlot(op13())

   output$plot9 <- renderPlot(op14)
   })
}

# Run the app ----
shinyApp(ui = ui, server = server)


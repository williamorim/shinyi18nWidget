#' Create a i18nInput
#' 
#' Creates a widget to use alongside the shiny.i18n package.
#' 
#' @param inputId A character string.
#' @param choices A character vector with language options.
#' 
#' @export 
i18nInput <- function(inputId, choices) {
  n <- length(choices)
  l <- htmltools::tagList()

  format_values <- names(choices)
  values <- as.character(choices)
  
  if (is.null(format_values)) {
    format_values <- values
  }

  sep <- htmltools::span(" | ")

  for (i in 1:n) {
    element <- htmltools::span(
      class = "lang-option lang-active",
      format_values[i],
      onclick = glue::glue("Shiny.setInputValue('{inputId}', '{values[i]}')")
    )

    l <- htmltools::tagList(l, element)
    
    if(i != n) {
      l <- htmltools::tagList(l, sep)
    }
  }

  js <- system.file("script.js", package = "shinyi18nWidget")

  l <- htmltools::tagList(l, htmltools::tags$script(src = js))

  return(l)
}


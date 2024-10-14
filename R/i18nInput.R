#' Create a i18nInput
#'
#' Creates a widget to use alongside the shiny.i18n package.
#'
#' @param inputId A character string.
#' @param choices A character vector with language options.
#' @param selected A character string with the selected language.
#'
#' @export
i18nInput <- function(inputId, choices, selected = NULL) {

  if (length(unique(choices)) != length(choices)) {
    stop("choices must be unique")
  }

  if (is.null(selected)) {
    selected <- choices[1]
  }

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
      class = "lang-option",
      format_values[i],
      `data-value` = values[i]
    )

    if (selected == values[i]) {
      element <- htmltools::tagAppendAttributes(
        element,
        class = "lang-active"
      )
    }

    l <- htmltools::tagList(l, element)

    if (i != n) {
      l <- htmltools::tagList(l, sep)
    }
  }

  l <- htmltools::div(
    id = inputId,
    class = "shiny-i18n-input",
    l,
    i18nInput_dependency()
  )

  return(l)
}

i18nInput_dependency <- function() {
  htmltools::htmlDependency(
    name = "shinyi18nWidget",
    version = "0.1.0",
    src = "assets",
    package = "shinyi18nWidget",
    stylesheet = "style.css",
    script = list(src = "script.js", defer = "")
  )
}

#' Update a i18nInput
#'
#' @param session A shiny session object.
#' @param inputId A character string.
#' @param selected A character string with the selected language.
#'
#' @export
updateI18nInput <- function(session = getDefaultReactiveDomain(), inputId, selected = NULL) {
  message <- list(value = selected)
  session$sendInputMessage(inputId, message)
}


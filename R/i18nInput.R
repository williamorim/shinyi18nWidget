#' Create a i18nInput
#'
#' Creates a widget to use alongside the shiny.i18n package.
#'
#' @param inputId A character string.
#' @param choices A character vector with language options.
#' @param seleted A character string with the selected language.
#'
#' @export
i18nInput <- function(inputId, choices, selected = NULL) {
  if (length(unique(choices)) != length(choices)) {
    stop("choices must be unique")
  }
  if (is.null(selected)) {
    selected <- choices[1]
  }
  selected <- shiny::restoreInput(id = inputId, default = selected)

  l <- htmltools::tagList()

  html <- i18nOptions(choices, selected)

  html <- htmltools::div(
    id = inputId,
    class = "shiny-input-container shiny-i18n-input",
    html,
    `data-value` = selected,
    i18nInput_dependency()
  )

  return(html)
}

i18nOptions <- function(choices, selected) {
  n <- length(choices)
  l <- htmltools::tagList()

  format_values <- names(choices)
  values <- as.character(choices)

  if (is.null(format_values)) {
    format_values <- values
  }

  sep <- htmltools::span(" | ")

  for (i in 1:n) {
    element <- htmltools::tags$option(
      class = "lang-option",
      format_values[i],
      value = values[i]
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

#' Update i18nInput
#'
#' This function updates the internationalization (i18n) input widget with new language options.
#'
#' @param session The Shiny session object.
#' @param inputId A character string representing the ID of the input element.
#' @param selected A character string with the selected language.
#'
#' @return None. This function is used for its side effects.
#' @export
updateI18nInput <- function(session = getDefaultReactiveDomain(),
                            inputId, selected = NULL) {
  shiny:::validate_session_object(session)
  message <- shiny:::dropNulls(list(value = selected))
  session$sendInputMessage(inputId, message)
}



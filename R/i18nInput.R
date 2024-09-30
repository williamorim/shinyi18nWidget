#' Create a i18nInput
#'
#' Creates a widget to use alongside the shiny.i18n package.
#'
#' @param inputId A character string.
#' @param choices A character vector with language options.
#'
#' @export
i18nInput <- function(inputId, choices, selected = NULL) {
  selected <- shiny::restoreInput(id = inputId, default = selected)

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
      `data-value` = values[i],
      format_values[i]
    )

    if (values[i] == selected | format_values[i] == selected) {
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

  htmltools::div(
    id = inputId,
    class = "shiny-i18n-input",
    l,
    html_dependency_i18nInput()
  )
}

html_dependency_i18nInput <- function() {
  htmltools::htmlDependency(
    "shinyi18nWidget",
    "1.0.0",
    src = "assets",
    package = "shinyi18nWidget",
    script = list(src = "script.js", defer = ""),
    stylesheet = "style.css"
  )
}

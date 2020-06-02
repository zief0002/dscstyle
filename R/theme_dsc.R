#' ggplot DSC-WAV theme
#'
#' This function is a theme function for use with ggplot2.
#' It tries to have a very tight composition, suitable for email or chat message
#'
#' http://ggplot2.tidyverse.org/reference/theme.html
#' @import ggplot2
#' @param size Font size
#' @param family Font family
#' @seealso \code{\link[ggplot2]{theme}}

# Notes on primitives: (defaults)
# element_text:
#   family = font family
#   face = font face
#   colour = font color
#   size = font size (pts)
#   hjust = horiz just .5
#   vjust = vert just .5
#   angle = text angle 0
#   lineheight = line height 1.1

# element_line
#   color = line color "black"
#   size = line thickness .5
#   linetype = type of line 1

# element_rect
#   fill = fill color NA
#   colour = border color "black"
#   size = thickness of border line .5
#   linetype = type of border line  1



#' @export
theme_dsc <- function(size = 12, family = "Oswald") {
  theme(
    # Text elements
    text = element_text(size = size, family = family),
    plot.caption = element_text(hjust = 0, color = "#808080"),
    axis.text = element_text(margin = c(0, 0, 0, 0)),
    legend.text = element_text(),
    title = element_text(size = size),
    axis.title = element_text(size = size, margin = c(0, 0, 0, 0)),
    legend.title = element_blank(),
    plot.title = element_text(size = rel(2)),
    plot.subtitle = element_blank(), # AP style - no subtitles
    #    strip.text = element_blank(),

    # Line elements
    #    line = element_blank(),
    axis.ticks.y = element_blank(),
    #    axis.line = element_blank(),
    #    panel.grid = element_blank(),
    panel.grid.major = element_line(color = '#939598', linetype = 'dotted'),
    panel.grid.minor = element_blank(),

    # Rect elements
    #    rect = element_blank(),
    legend.key = element_blank(),
    #    legend.background = element_blank(),
    #    legend.box.background = element_blank(),
    panel.background = element_blank(), # Drawn underneath the plot
    #    panel.border = element_blank(), # Drawn on top of plot, covering tick marks and grid lines (fill = NA)
    plot.background = element_blank(),
    #    strip.background = element_blank(),

    # Other
    axis.ticks.length = unit(4, "pt"),
    #    legend.margin = margin(-15, 0, -15, 0, "pt"),
    #    legend.spacing = unit(0, 'pt'),
    legend.key.size = unit(10, 'pt'),
    #    legend.text.align = 0, # 0: left, 1: right
    #    legend.title.align = 1,
    legend.position = 'none', # none, left, right, bottom, top, or two-element numeric vector
    #    legend.direction = "vertical", # horizontal, vertical
    #    legend.justification = "center", # center or two-element numeric vector
    #    legend.box = "horizontal", # horizontal, vertical
    #    legend.box.just = "left", # top, bottom, left, right
    #    legend.box.margin = margin(0, 0, 0, 0, "pt"), # specified
    #    legend.box.spacing = unit(0, "pt"),

    panel.spacing = unit(0, "pt"),
    plot.margin = margin(10, 10, 5, 5, "pt"),
    strip.placement = "inside"#, inside, outside
    #aspect.ratio = 3/4
  )}


# Color data object
# This contains the color definitions specified in the style guide
dsc.pal <- function(name, direction = 1) {
  palette <-
    switch(
      name,
      dark = c(
        "#03315d", # cool black
        "#f7b766", # mellow apricot
        "#2c6a7e", # ming
        "#e75a7c", # dark pink
        "#838383"  # old silver
      ),
      light = c(
        "#93b7be", # pewter blue
        "#4f5d75", # black coral
        "#f4bc5a", # maximum yellow red
        "#6da552", # palm leaf
        "#b53a38"  # pale carmine
      ),
      blues = c(
        "#d7dae0", # gainsboro
        "#a3aab7", # dark medium gray
        "#6f7a8e", # slate gray
        "#474e5b", # outer space
        "#1f2227"  # dark gunmetal
      )
    )
  if (direction == -1) {
    palette <- rev(palette)
  }
  palette
}

#' @export
#' @rdname theme_dsc
#' @param ... arguments passed to \code{\link[ggplot2]{scale_color_manual}}
#' @param palette Color palette
#' @param direction 1 or 0
#'
scale_color_dsc <- function(..., palette = "default", direction = 1) {

  palette_function <- function(x) {
    dsc.pal(x, direction)
  }

  if (palette == "default") {
    scale_color_manual(..., values = unlist(
      lapply(
        c("dark",
          "light",
          "blues"
          ),
        palette_function)))
  } else {
    scale_color_manual(..., values = palette_function(palette))
  }
}

#' @export
#' @rdname theme_dsc
#' @param ... arguments passed to \code{\link[ggplot2]{scale_fill_manual}}
scale_fill_dsc <- function(..., palette = "default", direction = 1) {

  palette_function <- function(x) {
    dsc.pal(x, direction)
  }

  if (palette == "default") {
    scale_fill_manual(..., values = unlist(
      lapply(
        c("dark",
          "light",
          "blues"
          ),
        palette_function)))
  } else {
    scale_fill_manual(..., values = palette_function(palette))
  }
}

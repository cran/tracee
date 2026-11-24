## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.alt = "Example plot of ChickWeight data saved with tracee, with a stamp showing output file, script and time underneath."
)

## ----setup--------------------------------------------------------------------
library(tracee)
library(ggplot2)
library(flextable)
library(data.table)

## Flip this to TRUE to actually write files to disk when running this
## vignette interactively.
writeOutput <- FALSE

## Arguments used throughout this vignette to "stamp" outputs - see the
## Stamping section below.
script <- "writing-outputs.Rmd"
time   <- "2024-01-15 10:00"
model  <- "run001"

## ----ggwrite-single-----------------------------------------------------------
data(ChickWeight)

p1 <- ggplot(ChickWeight, aes(Time, weight, group = Chick, colour = factor(Diet))) +
  geom_line() +
  labs(colour = "Diet")

## View on screen (save = FALSE is the default behavior we use throughout
## this vignette via `writeOutput`)
ggwrite(p1, file = "chickweight_lines1.png", save = writeOutput)

## ----ggwrite-stamp------------------------------------------------------------
ggwrite(p1, script = script, file = "chickweight_lines2.png",
        canvas = "wide", save = writeOutput)

## Including time and model in the stamp
ggwrite(p1, script = script, time = time, model = model,
        file = "chickweight_lines3.png", save = writeOutput)

## ----ggwrite-formats-canvas---------------------------------------------------
## Two file formats from one call
ggwrite(p1, file = "chickweight_lines4.png",
        formats = c("png", "pdf"), save = writeOutput)

## Two canvas sizes from one call -> chickweight_small.png, chickweight_large.png
ggwrite(p1, file = "chickweight_lines5.png",
        canvas = list(small = "standard", large = "wide"),
        save = writeOutput)

## ----ggwrite-list-------------------------------------------------------------
p2 <- ggplot(ChickWeight, aes(Time, weight)) +
  geom_point(alpha = 0.3)

plots <- list(lines = p1, points = p2)

## Separate files: chickweight_lines.png, chickweight_points.png
ggwrite(plots, file = "chickweight.png", use.names = TRUE, save = writeOutput)

## Single multi-page PDF: chickweight.pdf (2 pages)
ggwrite(plots, file = "chickweight.pdf", onefile = TRUE, save = writeOutput)

## ----ftwrite-single-----------------------------------------------------------
ft1 <- flextable(head(ChickWeight, 10))

## Write a single table, format inferred from the file extension
ftwrite(ft1, file = "chickweight_table.docx", save = writeOutput)

## ----ftwrite-stamp------------------------------------------------------------
ftwrite(ft1, script = script, time = time, model = model,
        file = "chickweight_table_1.docx", save = writeOutput)

## ----ftwrite-formats----------------------------------------------------------
ftwrite(ft1, file = "chickweight_table_2.docx",
        formats = c("docx", "html"), save = writeOutput)

## ----ftwrite-list-------------------------------------------------------------
ft2 <- flextable(
as.data.frame(summary(ChickWeight))
[, 1:2])

ft2 <- flextable(
as.data.frame(ChickWeight[1:2,1:2]))

ftables <- list(raw = ft1, summary = ft2)

lapply(ftables,class)

## Creates chickweight_tables_raw.docx, chickweight_tables_summary.docx
ftwrite(tables, file = "chickweight_tables_3.docx", save = writeOutput)

## ----lwrite-example-----------------------------------------------------------
outputs <- list(
  weight_trajectories = p1,
  weight_by_time      = p2,
  summary_table       = ft2
)

## Each element is written using the function appropriate for its class,
## with file names derived from the list names, stamped consistently with
## script, time, and model.
lwrite(outputs, 
       script = script, time = time, model = model,
       save = writeOutput)

## ----fun-path, eval = FALSE---------------------------------------------------
# ggwrite(p1, file = "chickweight_lines_06.png",
#         script = script, time = time, model = model,
#         subdir = "exploratory",
#         path.format = "%model-%name", save = writeOutput)
# 
# lwrite(outputs, dir = "outputs",
#        script = script, time = time, model = model,
#        path.format = "%model/%model-%name")


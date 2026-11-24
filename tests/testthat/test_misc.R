test_that("padZeros",{
  expect_equal(padZeros(5,3),"005")
  expect_equal(padZeros(c(1,10,100),4),c("0001","0010","0100"))
})

test_that("ggwater adds a watermark layer",{
  library(ggplot2)
  p1 <- ggplot(data.frame(x=1,y=1),aes(x,y))+geom_point()
  p2 <- p1+ggwater("Draft")
  expect_s3_class(p2,"ggplot")
  expect_equal(length(p2$layers),length(p1$layers)+1)
})

test_that("deprecated flextable wrappers",{
  ft <- flextable::flextable(data.frame(a=1))
  expect_warning(res <- stampFlextab(ft,script="ex.R",time=""),"deprecated")
  expect_s3_class(res,"flextable")

  dir.out <- withr::local_tempdir()
  expect_warning(
    writeFlextab(ft,file=file.path(dir.out,"tab"),script="ex.R",formats="docx",save=TRUE,quiet=TRUE),
    "deprecated")
  expect_true(file.exists(file.path(dir.out,"tab.docx")))
})

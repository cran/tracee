## Draw plots printed during tests to a null device. Without this, R
## opens a default pdf device and leaves Rplots.pdf in tests/testthat.
grDevices::pdf(NULL)
withr::defer(grDevices::dev.off(), teardown_env())

# Initial settings
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
# The following warning message is issued when running the line above. There is no need to worry about it.
# Warning message:
  # In FUN(X[[i]], ...) :
  # No Rcpp::export attributes or RCPP_MODULE declarations found in source

# 0) DEFAULT EXAMPLE ##########################################################################################
data(meuse.grid, package = "sp")
candi <- meuse.grid[1:1000, 1:2]
covars <- meuse.grid[1:1000, 5]
schedule <- scheduleSPSANN(
  chains = 1, initial.temperature = 20, x.max = 1540, y.max = 2060, 
  x.min = 0, y.min = 0, cellsize = 40)
set.seed(2001)
res <- optimCLHS(
  points = 10, candi = candi, covars = covars, use.coords = TRUE,
  clhs.version = "fortran", weights = list(O1 = 0.5, O3 = 0.5), schedule = schedule)
objSPSANN(res) - objCLHS(
  points = res, candi = candi, covars = covars, use.coords = TRUE, 
  clhs.version = "fortran", weights = list(O1 = 0.5, O3 = 0.5))

# 1) FACTOR COVARIATES USING THE COORDINATES AND MANY CHAINS ##################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 6:7]
schedule <- scheduleSPSANN(chains = 100, initial.temperature = 10)
set.seed(2001)
res <- optimCLHS(
  points = 100, candi = candi, covars = covars,  use.coords = TRUE, schedule = schedule, plotit = TRUE, 
  clhs.version = "fortran", weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))
objSPSANN(res) - 
  objCLHS(points = res, candi = candi, covars = covars, use.coords = TRUE, clhs.version = "fortran",
          weights = rev(list(O1 = 1/3, O2 = 1/3, O3 = 1/3)))

# 2) FACTOR COVARIATES USING THE COORDINATES WITH A FEW POINTS ################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 6:7]
schedule <- scheduleSPSANN(chains = 1, initial.temperature = 10)
set.seed(2001)
res <-  optimCLHS(
  points = 10, candi = candi, covars = covars, use.coords = TRUE, schedule = schedule, plotit = TRUE, 
  clhs.version = "fortran", weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))
objSPSANN(res) - 
  objCLHS(points = res, candi = candi, covars = covars, use.coords = TRUE, clhs.version = "fortran",
          weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))

# 3) CATEGORICAL COVARIATES WITH MANY COVARIATES AND MANY POINTS ##############################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, rep(c(6, 7), 10)]
schedule <- scheduleSPSANN(chains = 1, initial.temperature = 10)
set.seed(2001)
res <- optimCLHS(
  points = 500, candi = candi, covars = covars, use.coords = T, schedule = schedule, plotit = TRUE, 
  clhs.version = "fortran", weights = rev(list(O1 = 1/3, O2 = 1/3, O3 = 1/3)))
objSPSANN(res) -
  objCLHS(points = res, candi = candi, covars = covars, use.coords = TRUE, clhs.version = "fortran",
          weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))

# 4) ADD TEN POINTS TO AN EXISTING SAMPLE CONFIGURATION #######################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 6:7]
schedule <- scheduleSPSANN(chains = 500, initial.temperature = 10)
free <- 10
set.seed(1984)
id <- sample(1:nrow(candi), 40)
fixed <- cbind(id, candi[id, ])
objCLHS(points = fixed, candi = candi, covars = covars, use.coords = TRUE, clhs.version = "fortran",
        weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))
set.seed(2001)
res <-  optimCLHS(
  points = list(free = free, fixed = fixed), candi = candi, covars = covars, use.coords = TRUE, 
  schedule = schedule, plotit = TRUE, clhs.version = "fortran", weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))
objSPSANN(res) -
  objCLHS(points = res, candi = candi, covars = covars, use.coords = TRUE, clhs.version = "fortran",
          weights = list(O1 = 1/3, O2 = 1/3, O3 = 1/3))

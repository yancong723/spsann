# Initial settings
rm(list = ls())
gc()
require(pedometrics)
require(sp)
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)

# 0) DEFAULT EXAMPLE ###########################################################
require(sp)
data(meuse.grid)
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 5]
schedule <- scheduleSPSANN(initial.temperature = 1, chains = 1,
                           x.max = 1540, y.max = 2060, x.min = 0, 
                           y.min = 0, cellsize = 40)
set.seed(2001)
res <- optimDIST(points = 10, candi = candi, covars = covars,
                 use.coords = TRUE, schedule = schedule)
objSPSANN(res) -
  objDIST(points = res, candi = candi, covars = covars, use.coords = TRUE)

# 1) GREEDY ALGORITHM #########################################################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid)
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 5]
schedule <- scheduleSPSANN(initial.acceptance = 0.01)
set.seed(2001)
res <- optimDIST(
  points = 100, candi = candi, covars = covars, use.coords = TRUE, schedule = schedule, plotit = TRUE)
objSPSANN(res) -
  objDIST(points = res, candi = candi, covars = covars, use.coords = TRUE)

# 2) FACTOR COVARIATES WITH THE COORDINATES ###################################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
boundary <- meuse.grid
sp::coordinates(boundary) <- c("x", "y")
sp::gridded(boundary) <- TRUE
boundary <- rgeos::gUnaryUnion(as(boundary, "SpatialPolygons"))
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 6:7]
schedule <- scheduleSPSANN(initial.temperature = 0.5)
set.seed(2001)
res <- optimDIST(
  points = 30, candi = candi, covars = covars, use.coords = TRUE, 
  schedule = schedule, plotit = TRUE, boundary = boundary)
objSPSANN(res)
objDIST(
  points = res, candi = candi, covars = covars, use.coords = TRUE)
plot(res, boundary = boundary)

# 3) FACTOR AND NUMERIC COVARIATES WITH THE COORDINATES #######################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid)
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, c(1, 2, 5:7)]
schedule <- scheduleSPSANN(initial.temperature = 0.5, chains = 5)
set.seed(2001)
resA <- optimDIST(
  points = 100, candi = candi, covars = covars, progress = "tk", use.coords = TRUE, plotit = TRUE, 
  schedule = schedule)
objSPSANN(resA)
objDIST(points = resA, candi = candi, covars = covars, use.coords = TRUE)

# 4) ADD TEN POINTS TO AN EXISTIG FIXED SAMPLE CONFIGURATION ##################################################
rm(list = ls())
gc()
sapply(list.files("R", full.names = TRUE, pattern = ".R$"), source)
sapply(list.files("src", full.names = TRUE, pattern = ".cpp$"), Rcpp::sourceCpp)
data(meuse.grid, package = "sp")
boundary <- meuse.grid
sp::coordinates(boundary) <- c("x", "y")
sp::gridded(boundary) <- TRUE
boundary <- rgeos::gUnaryUnion(as(boundary, "SpatialPolygons"))
candi <- meuse.grid[, 1:2]
covars <- meuse.grid[, 6:7]
schedule <- scheduleSPSANN(initial.temperature = 5, stopping = 200)
free <- 10
set.seed(1984)
id <- sample(1:nrow(candi), 40)
fixed <- cbind(id, candi[id, ])
objDIST(points = fixed, candi = candi, covars = covars, use.coords = TRUE)
set.seed(2001)
res <- optimDIST(
  points = list(free = free, fixed = fixed), candi = candi, covars = covars, use.coords = TRUE, 
  schedule = schedule, plotit = TRUE, boundary = boundary)
objSPSANN(res) -
  objDIST(points = res, candi = candi, covars = covars, use.coords = TRUE)
plot(res, boundary = boundary)

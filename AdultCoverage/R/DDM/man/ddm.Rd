% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ddm.R
\name{ddm}
\alias{ddm}
\title{run all three deaths registration coverage estimation methods}
\usage{
ddm(
  X,
  minA = 15,
  maxA = 75,
  minAges = 8,
  exact.ages.ggb = NULL,
  exact.ages.seg = NULL,
  eOpen = NULL,
  deaths.summed = FALSE,
  mig.summed = deaths.summed,
  lm.method = "oldschool",
  opt.method = "r2",
  nx.method = 2,
  delta = FALSE
)
}
\arguments{
\item{X}{\code{data.frame} with columns, \code{pop1}, \code{pop2}, \code{deaths}, \code{mig} (optional), \code{date1}, \code{date2}, \code{age}, and \code{id} (if there are more than 1 region/sex/intercensal period).}

\item{minA}{the lowest age to be included in search}

\item{maxA}{the highest age to be included in search (the lower bound thereof)}

\item{minAges}{the minimum number of adjacent ages to be used in estimating}

\item{exact.ages.ggb}{optional. A user-specified vector of exact ages to use for coverage estimation in the GGB method and the GGB stage of the GGBSEG method.}

\item{exact.ages.seg}{optional. A user-specified vector of exact ages to use for coverage estimation in the SEG method and the SEG stage of the GGBSEG method.}

\item{eOpen}{optional. A user-specified value for remaining life-expectancy in the open age group.}

\item{deaths.summed}{logical. is the deaths column given as the total per age in the intercensal period (\code{TRUE}). By default we assume \code{FALSE}, i.e. that the average annual was given.}

\item{mig.summed}{logical. Is the (optional) net migration column \code{mig} given as the total per age in the intercensal period (\code{TRUE}). By default we assume \code{FALSE}, i.e. that the average annual was given.}

\item{lm.method}{character, one of:\itemize{
\item{\code{"oldschool"}} default sd ratio operation of still unknown origin
\item{\code{"lm"} or \code{"ols"}} for a simple linear model
\item{\code{"tls"}, \code{"orthogonal"}, or \code{"deming"}} for total least squares
\item{\code{"tukey"}, \code{"resistant"}, or "\code{"median"}} for Tukey's resistant line method
}}

\item{opt.method}{what kind of residual do we minimize? choices \code{"RMS"},\code{"logRMS"}, \code{"ORSS"}, \code{"logORSS"} (experimental)}

\item{nx.method}{either 2 or 4. 4 is smoother.}

\item{delta}{logical. Should the delta variant of SEG be done?}
}
\value{
data.frame with columns \code{$cod}, \code{$ggb}, \code{$bh1}, \code{$bh2}, \code{$lower}, and \code{$upper}.
}
\description{
Estimate the generalized growth balance method, and the two Bennett-Horiuchi methods of estimating death registration coverage. This requires two censuses and an estimate of the deaths in each 5-year age group between censuses. This might be the arithmetic average of deaths in each age class, or simply the average of deaths around the time of the two censuses. All methods use some stable population assumptions.
}
\details{
All methods require some specification about which age range to base results on. If not given, an optimal age range will be estimated automatically, and this information is returned to the user. To identify an age-range in the visually, see \code{ggbChooseAges()}, when working with a single year/sex/region of data (SEG varient of this visual picker is forthcoming). The automatic age-range determination feature of this function tries to implement an intuitive way of picking ages that follows the advice typically given for doing so visually. We minimize the root of the average squared residual (RMSE) between the fitted line and right term for GGB, and we minimize the RMSE of a horizontal sequence of Cx estimates for SEG. If you want coverage estimates for a variety of partitions (intercensal periods/regions/by sex), then stack them, and use a variable called \code{$cod} with unique values for each data partition. If data is partitioned using the variable \code{$cod}, then the age range automatically determined might not be the same for each partition. If user-specified, (using vectors of specified ages \code{exact.ages.ggb} and/or \code{exact.ages.seg}) the age ranges will be the same for all partitions. If you want to specify particular age ranges for each data partition, then you'll need to loop it somehow.

All three methods require time points of the two censuses. Census dates can be given in a variety of ways: 1) (preferred) using \code{Date} classes, and column names \code{$date1} and \code{$date2} (or an unambiguous character string of the date, like, \code{"1981-05-13"}) or 2) by giving column names \code{"day1","month1","year1","day2","month2","year2"} containing respective integers. If only \code{year1} and \code{year2} are given, then we assume January 1 dates. If year and month are given, then we assume dates on the first of the month.  Different values of \code{$cod} could indicate sexes, regions, intercensal periods, etc. The \code{$deaths} column should refer to the average annual deaths for each age class in the intercensal period. Sometimes one uses the arithmetic average of recorded deaths in each age, or simply the average of the deaths around the time of census 1 and census 2.

The synthetic extinct generation methods require an estimate of remaining life expectancy in the open age group of the data provided. This is produced using a standard reference to the Coale-Demeny West model life tables. That is a place where things can be improved.
}
\examples{
# The Mozambique data
res <- ddm(Moz)
head(res)
 # The Brasil data
 BM <- ddm(BrasilMales,
           exact.ages.ggb=seq(15,75,by=5),
           exact.ages.seg=seq(25,60,by=5),
           delta = TRUE,
           lm.method = "resistant")
 \dontrun{
 ddmplot(BM)
 abline(h=1)
}
}
\references{
Bennett Neil G, Shiro Horiuchi. Estimating the completeness of death registration in a closed population. Population Index. 1981; 1:207-221.

Hill K. Estimating census and death registration completeness. Asian and Pacific Population Forum. 1987; 1:1-13.

Hill K, You D, Choi Y. Death distribution methods for estimating adult mortality: sensitivity analysis with simulated data errors. Demographic Research. 2009; 21:235-254.

Brass, William, 1975.  Methods for Estimating Fertility and Mortality from Limited and Defective Data, Carolina Population Center, Laboratory for Population Studies, University of North Carolina, Chapel Hill.

Preston, S. H., Coale, A. J., Trussel, J. & Maxine, W. Estimating the completeness of reporting of adult deaths in populations that are approximately stable.  Population Studies, 1980; v.4: 179-202
}

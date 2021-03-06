% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_functions.R
\name{ggbChooseAges}
\alias{ggbChooseAges}
\title{interactively determine ages to use for estimating coverage}
\usage{
ggbChooseAges(
  X,
  minA = 15,
  maxA = 75,
  minAges = 8,
  exact.ages = NULL,
  maxit = 15,
  deaths.summed = FALSE,
  mig.summed = deaths.summed,
  lm.method = "oldschool",
  opt.method = "r2",
  nx.method = 2
)
}
\arguments{
\item{X}{\code{data.frame} with columns, \code{pop1}, \code{pop2}, \code{deaths}, \code{mig} (optional), \code{date1}, \code{date2}, \code{age}, and \code{id} (if there are more than 1 region/sex/intercensal period).}

\item{minA}{the lowest age to be included in search}

\item{maxA}{the highest age to be included in search (the lower bound thereof)}

\item{minAges}{the minimum number of adjacent ages to be used in estimating}

\item{exact.ages}{optional. A user-specified vector of exact ages to use for coverage estimation}

\item{maxit}{up to how many times do you want to let yourself fiddle with the age range?}

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
}
\value{
\code{data.frame} containing elements \code{$coverage}, \code{$lower}, \code{$upper}, and \code{ages}.
}
\description{
In a spreadsheet one would typically set up the GGB method to produce a plot that updates as the user changes the age range. This function implements that kind of work flow. This will be intuitive for spreadsheet users, but it does not scale well. Imagine you have 200 territorial units, then you would not want to repeat this task. \code{ggb()} does the same thing automatically. You can compare the age range you select manually with the one given back by \code{ggb()} as a diagnostic, for instance. To set up the plot device, just give a single year/region/sex of data. By default it will give the RMSE-optimized age range to start with, but you can specify a  vector of exact ages to use as well. All points are plotted, with a fitted line that has been set to a subset of the points, which is plotted in a different color. You can click any point to change the age range, and the plot updates accordingly, up to a maximum of 15 clicks so you don't waste your time. You can stop the plot by either clicking on the graphics device outside the plot area or clicking out the 15 tries (or more if you increase \code{maxit}).
}
\details{
If you want to send the results of this into \code{ggb()}, you can do so by setting \code{Exact.ages} to \code{seq(lower,upper,by=5)}, where \code{$lower}, and \code{$upper} are the results returned from \code{ggbChooseAges()} after you're done manually determining the age range.
}
\examples{
\dontrun{
# for interactive sessions only
# *click points to adjus age range used (yellow)
# *click in margin to stop and return coverage results
ggbChooseAges(Moz)
}
}

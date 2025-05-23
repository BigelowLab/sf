% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/crs.R
\docType{data}
\name{st_crs}
\alias{st_crs}
\alias{st_crs.sf}
\alias{st_crs.numeric}
\alias{st_crs.character}
\alias{st_crs.sfc}
\alias{st_crs.bbox}
\alias{st_crs.CRS}
\alias{st_crs.crs}
\alias{st_crs<-}
\alias{st_crs<-.sf}
\alias{st_crs<-.sfc}
\alias{st_set_crs}
\alias{NA_crs_}
\alias{is.na.crs}
\alias{$.crs}
\alias{format.crs}
\alias{st_axis_order}
\title{Retrieve coordinate reference system from object}
\format{
An object of class \code{crs} of length 2.
}
\usage{
st_crs(x, ...)

\method{st_crs}{sf}(x, ...)

\method{st_crs}{numeric}(x, ...)

\method{st_crs}{character}(x, ...)

\method{st_crs}{sfc}(x, ..., parameters = FALSE)

\method{st_crs}{bbox}(x, ...)

\method{st_crs}{CRS}(x, ...)

\method{st_crs}{crs}(x, ...)

st_crs(x) <- value

\method{st_crs}{sf}(x) <- value

\method{st_crs}{sfc}(x) <- value

st_set_crs(x, value)

NA_crs_

\method{is.na}{crs}(x)

\method{$}{crs}(x, name)

\method{format}{crs}(x, ...)

st_axis_order(authority_compliant = logical(0))
}
\arguments{
\item{x}{numeric, character, or object of class \link{sf} or \link{sfc}}

\item{...}{ignored}

\item{parameters}{logical; \code{FALSE} by default; if \code{TRUE} return a list of coordinate reference system parameters, with named elements \code{SemiMajor}, \code{InvFlattening}, \code{units_gdal}, \code{IsVertical}, \code{WktPretty}, and \code{Wkt}}

\item{value}{one of (i) character: a string accepted by GDAL, (ii) integer, a valid EPSG value (numeric), or (iii) an object of class \code{crs}.}

\item{name}{element name}

\item{authority_compliant}{logical; specify whether axis order should be
handled compliant to the authority; if omitted, the current value is printed.}
}
\value{
If \code{x} is numeric, return \code{crs} object for EPSG:\code{x};
if \code{x} is character, return \code{crs} object for \code{x};
if \code{x} is of class \code{sf} or \code{sfc}, return its \code{crs} object.

Object of class \code{crs}, which is a list with elements \code{input} (length-1 character)
and \code{wkt} (length-1 character).
Elements may be \code{NA} valued; if all elements are \code{NA} the CRS is missing valued, and coordinates are
assumed to relate to an arbitrary Cartesian coordinate system.

\code{st_axis_order} returns the (logical) current value if called without
argument, or (invisibly) the previous value if it is being set.
}
\description{
Retrieve coordinate reference system from sf or sfc object

Set or replace retrieve coordinate reference system from object
}
\details{
The *crs functions create, get, set or replace the \code{crs} attribute
of a simple feature geometry list-column. This attribute is of class \code{crs},
and is a list consisting of \code{input} (user input, e.g. "EPSG:4326" or "WGS84"
or a proj4string), and \code{wkt}, an automatically generated wkt2 representation of the crs.
If \code{x} is identical to the wkt2 representation, and the CRS has a name, this name
is used for the \code{input} field.

Comparison of two objects of class \code{crs} uses the GDAL function
\code{OGRSpatialReference::IsSame}.

In case a coordinate reference system is replaced, no transformation takes
place and a warning is raised to stress this.

\code{NA_crs_} is the \code{crs} object with missing values for \code{input} and \code{wkt}.

the \code{$} method for \code{crs} objects retrieves named elements
using the GDAL interface; named elements include
\code{SemiMajor}, \code{SemiMinor}, \code{InvFlattening}, \code{IsGeographic},
\code{units_gdal}, \code{IsVertical}, \code{WktPretty}, \code{Wkt},
\code{Name}, \code{proj4string}, \code{epsg}, \code{yx},
\code{ud_unit}, and \code{axes} (this may be subject to changes in future GDAL versions).

Note that not all valid CRS have a corresponding \code{proj4string}.

\code{ud_unit} returns a valid \link[units]{units} object or \code{NULL} if units are missing.

format.crs returns NA if the crs is missing valued, or else
the name of a crs if it is different from "unknown", or
else the user input if it was set, or else its "proj4string" representation;

\code{st_axis_order} can be used to get and set the axis order: \code{TRUE}
indicates axes order according to the authority
(e.g. EPSG:4326 defining coordinates to be latitude,longitude pairs), \code{FALSE}
indicates the usual GIS (display) order (longitude,latitude). This can be useful
when data are read, or have to be written, with coordinates in authority compliant order.
The return value is the current state of this (\code{FALSE}, by default).
}
\examples{
sfc = st_sfc(st_point(c(0,0)), st_point(c(1,1)))
sf = st_sf(a = 1:2, geom = sfc)
st_crs(sf) = 4326
st_geometry(sf)
sfc = st_sfc(st_point(c(0,0)), st_point(c(1,1)))
st_crs(sfc) = 4326
sfc
sfc = st_sfc(st_point(c(0,0)), st_point(c(1,1)))
sfc \%>\% st_set_crs(4326) \%>\% st_transform(3857)
st_crs("EPSG:3857")$input
st_crs(3857)$proj4string
pt = st_sfc(st_point(c(0, 60)), crs = 4326)
# st_axis_order() only has effect in GDAL >= 2.5.0:
st_axis_order() # query default: FALSE means interpret pt as (longitude latitude)
st_transform(pt, 3857)[[1]]
old_value = FALSE
if (compareVersion(sf_extSoftVersion()["GDAL"], "2.5.0") >= 0)
   (old_value = st_axis_order(TRUE))
# now interpret pt as (latitude longitude), as EPSG:4326 prescribes:
st_axis_order() # query current value
st_transform(pt, 3857)[[1]]
st_axis_order(old_value) # set back to old value
}
\keyword{datasets}

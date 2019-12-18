module Contrive

using LightGraphs

import Dates: Period, Day

include("task.jl")
include("project.jl")
include("scenario.jl")

export Project, Step, Root, Milestone
export adddep!, addtoptask, ordertasks

end # module

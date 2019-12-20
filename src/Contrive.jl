module Contrive

using LightGraphs
using DataStructures: OrderedDict, Stack
import Dates: Period, Day

include("task.jl")
include("project.jl")
include("scenario.jl")

export Project, AbstractTask, Step, Root, Milestone
export adddep!, addtoptask!, ordertasks, orderedges,
       taskidx, gettask, name

end # module

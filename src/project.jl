struct TaskDep
    first::AbstractTask
    second::AbstractTask
end

struct Project
    name::AbstractString
    description::AbstractString
    graph::AbstractArray{TaskDep,1}
end

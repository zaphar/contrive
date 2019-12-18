abstract type AbstractTask end

struct Step <: AbstractTask
    name::AbstractString
    description::AbstractString
end

struct Milestone <: AbstractTask
    name::AbstractString
    description::AbstractString
end

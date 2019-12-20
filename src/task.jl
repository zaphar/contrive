abstract type AbstractTask end

struct Step <: AbstractTask
    name::AbstractString
    description::AbstractString
end

struct Milestone <: AbstractTask
    name::AbstractString
    description::AbstractString
end

struct Root <: AbstractTask
end

name(t::Step) = t.name
name(t::Milestone) = t.name
name(t::Root) = "root"
struct Scenario
    name::AbstractString
    estimates::Dict{AbstractTask,Period}
end

# TODO(jwall): handle running a scenario.

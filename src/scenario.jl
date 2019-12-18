struct Scenario
    name::AbstractString
    estimates::AbstractArray{TaskDep,Period}
end

# TODO(jwall): handle running a scenario.

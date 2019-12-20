struct Project
    name::AbstractString
    description::AbstractString
    root::Root
    tasks::Array{AbstractTask, 1}
    graph::Array{Tuple{Int64, Int64}, 1}
end

Project(name, description) = begin
    p = Project(
        name,
        description,
        Root(),
        AbstractTask[],
        Tuple{Int64, Int64}[])
    addtask!(p, p.root)
    p
end

gettask(p::Project, idx) = get(p.tasks, idx, Nothing)

addtask!(p::Project, t::AbstractTask) = begin
    if !any(v -> v == t, p.tasks)
        push!(p.tasks, t)
    end
    return findfirst(v -> v == t, p.tasks)
end

taskidx(p::Project, t::AbstractTask) = findfirst(v -> v == t, p.tasks)

adddep!(p::Project, first, next) = begin
    firstidx = addtask!(p, first)
    nexxtidx = addtask!(p, next)
    push!(p.graph, (firstidx, nexxtidx))
end

addtoptask!(p::Project, t::AbstractTask) = adddep!(p, p.root, t)

makegraph(p::Project) = begin
    g = SimpleDiGraph{Int64}(length(p.graph)+1)
    for (from, to) in p.graph
        @assert add_edge!(g, from, to) "Unable to add edge to graph"
    end
    return g
end

ordertasks(p::Project) = begin
    g = makegraph(p)
    return LightGraphs.topological_sort_by_dfs(g)
end

orderedges(p::Project) = begin
    g = makegraph(p)
    es = OrderedDict{Int64, Array{Int64}}()
    for e in edges(dfs_tree(g, taskidx(p, p.root)))
        s = src(e)
        d = dst(e)
        edges = get(es, s, Int64[])
        push!(edges, d)
        es[s] = edges
    end
    return es
end
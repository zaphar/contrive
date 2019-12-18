using Contrive

using Test

@testset "Small linear project" begin
    name = "linear"
    desc = "A linear project"

    p = Project(name, desc)
    @test p.name == name
    @test p.description == desc
    @test length(p.tasks) == 1
    
    root = p.root

    step = Step("Step 1", "A first step")
    adddep!(p, root, step)

    @test length(p.tasks) == 2
    @test length(p.graph) == 1
    
    step2 = Step("Step 2", "A second step")
    adddep!(p, step, step2)
    
    @test length(p.tasks) == 3
    @test length(p.graph) == 2


    idx = Contrive.taskidx

    @test all(v -> (
        v == step
        || v == step2
        || v == root), p.tasks)
    @test any(v -> v == (idx(p, root), idx(p, step)), p.graph)
    @test any(v -> v == (idx(p, step), idx(p, step2)), p.graph)

    ts = Contrive.ordertasks(p)
    println(ts)
    @test length(p.tasks) == length(ts)
    @test ts[1] == idx(p, p.root)
end

@testset "Small non-linear project" begin
    name = "linear"
    desc = "A linear project"

    p = Project(name, desc)
    @test p.name == name
    @test p.description == desc
    @test length(p.tasks) == 1
    
    root = p.root

    step = Step("Step 1", "A first step")
    adddep!(p, root, step)

    @test length(p.tasks) == 2
    @test length(p.graph) == 1
    
    step2 = Step("Step 2", "A second step")
    adddep!(p, step, step2)
    
    @test length(p.tasks) == 3
    @test length(p.graph) == 2

    step3ish = Step("Step 3 ish", "A step with no dependencies")
    addtoptask(p, step3ish)
    @test length(p.tasks) == 4
    @test length(p.graph) == 3

    idx = Contrive.taskidx

    @test all(v -> (
        v == step
        || v == step2
        || v == root
        || v == step3ish), p.tasks)
    @test any(v -> v == (idx(p, root), idx(p, step)), p.graph)
    @test any(v -> v == (idx(p, root), idx(p, step3ish)), p.graph)
    @test any(v -> v == (idx(p, step), idx(p, step2)), p.graph)

    ts = Contrive.ordertasks(p)
    println(ts)
    @test length(p.tasks) == length(ts)
    @test ts[1] == idx(p, p.root)
    es = Contrive.orderedges(p)
    @test length(p.graph) == length(es)
    @test first(ts[1]) == idx(p, p.root)
end
using Contrive
using Compose
import Cairo, Fontconfig

using DataStructures: Stack

p = Project("simple", "A simple project")

script_step = Step("start", "Create a planning script")
create_s_step = Step("create scenario", "create a scenario")
run_s_step = Step("run scenario", "run the scenario")
silly_step = Step("silly", "a silly step")

addtoptask!(p, script_step)

adddep!(p, script_step, create_s_step)
adddep!(p, script_step, run_s_step)
addtoptask!(p, silly_step)

function drawtask(p, t, xpos, ypos, width, height)
    return (context(xpos, ypos, width, height),
            (context(), text(0.15, 0.5, name(t)), stroke("black")),
            (context(), rectangle(0.1, 0.1, 0.9, 0.9), fill("lightblue")),
        )
end

function drawtasks(p)
    squares = []
    xpos = 0.1; ypos = 0.1; width = 0.2; height = 0.2
    edgedict = orderedges(p)
    seen = Set{Int64}()
    stack = Stack{Int64}()
    for k in reverse(collect(keys(edgedict)))
        push!(stack, k)
    end
    while !isempty(stack)
        s = pop!(stack)
        if in(s, seen)
            continue
        end
        if taskidx(p, p.root) != s
            push!(squares, drawtask(p, gettask(p, s), xpos, ypos, width, height))
            xpos = xpos + 0.2
            ypos = ypos + 0.2
        end
        for e in get(edgedict, s, Int64[])
            push!(stack, e)
        end
        push!(seen, s)
    end
    return squares
end
boxes = drawtasks(p)
c = compose(context(), fill("white"), boxes...)
draw(Compose.SVG(), c)
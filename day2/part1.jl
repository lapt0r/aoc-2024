using DelimitedFiles


function getTarget(input)
    data = readdlm(input)
    data = map( v -> v == "" ? 0.0 : v, data)
    X=Int.(data)
    return X
end


function ProcessTarget(input::Matrix{Int64})
    result = []
    height,_ = size(input)
    for idx in 1:height
        line = []
        for itm in input[idx,:]
            if itm == 0
                break
            else
                push!(line,itm)
            end
        end
        width = length(line)
        differences = all( 0 < abs(line[i+1] - line[i]) <= 3 for i in 1:(width-1))
        increasing = all( line[i] < line[i+1] for i in 1:(width-1))
        decreasing = all(line[i] > line[i+1] for i in 1:(width-1))
        println("line ",line)
        println("differences are OK:", differences)
        println("monotonically increasing:", increasing)
        println("monotonically decreasing:", decreasing)
        safe = differences && (increasing || decreasing)
        push!(result,safe)
    end
    println(result)
    println(count(x -> x == true,result))
end

target = getTarget("input_test.txt")
ProcessTarget(target)

target = getTarget("input.txt")
ProcessTarget(target)
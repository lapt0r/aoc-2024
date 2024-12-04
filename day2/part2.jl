using DelimitedFiles


function getTarget(input)
    data = readdlm(input)
    data = map( v -> v == "" ? 0.0 : v, data)
    X=Int.(data)
    return X
end

function dampener(line::Vector{Int64})
    safe = isSafe(line)
    for i in 1:length(line)
        arr_under_test = copy(line)
        deleteat!(arr_under_test,i)
        safe = safe || isSafe(arr_under_test)
    end
    return safe
end

function isSafe(line::Vector{Int64})
    width = length(line)
    differences = all( 0 < abs(line[i+1] - line[i]) <= 3 for i in 1:(width-1))
    increasing = all( line[i] < line[i+1] for i in 1:(width-1))
    decreasing = all(line[i] > line[i+1] for i in 1:(width-1))
    safe = differences && (increasing || decreasing)
    return safe
end

function ProcessTarget(input::Matrix{Int64})
    result = Vector{Bool}()
    height,_ = size(input)
    for idx in 1:height
        line = Vector{Int64}()
        for itm in input[idx,:]
            if itm == 0
                break
            else
                push!(line,itm)
            end
        end
        safe = dampener(line)
        push!(result,safe)
    end
    println(result)
    println(count(x -> x == true,result))
end

target = getTarget("input_test.txt")
ProcessTarget(target)

target = getTarget("input.txt")
ProcessTarget(target)
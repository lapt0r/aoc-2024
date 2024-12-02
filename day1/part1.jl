

MATCHER = r"(\d+)\s*?(\d+)"

function extract(instr)
    m = match(MATCHER,instr)
    if !isnothing(m)
        left,right = m
        l = parse(Int,left)
        r = parse(Int,right)
        return (l,r)
    else
        print("failed to parse ", instr)
        return (0,0)
    end
end

function difference(tuple) 
    left,right = tuple
    return abs(left-right)
    end

function readDataFile(input)
    f = open(input)
    rawdata = readlines(f)
    data = map(extract,rawdata)
    return data
    # unzip and sort

    lefts = map(t -> t[1], data)
    rights = map(t -> t[2], data)

    sorted_lefts = sort(lefts)
    sorted_rights = sort(rights)

    sorted = zip(sorted_lefts, sorted_rights)
    return sorted
end

data = readDataFile("test_input.txt")
result = reduce(+,map(difference, data))
println("test result is ",result);

data = readDataFile("input.txt")
result = reduce(+,map(difference, data))
println("result is ",result)
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

function occurrences(value,arr)
    return length(findall(x -> x == value, arr ))
end

function readDataFile(input)
    f = open(input)
    rawdata = readlines(f)
    data = map(extract,rawdata)

    lefts = map(t -> t[1], data)
    rights = map(t -> t[2], data)
    sorted_lefts = sort(lefts)
    sorted_rights = sort(rights)
    solution = reduce(+,map(x -> occurrences(x,sorted_rights) * x,sorted_lefts))
    println("solution for ",input," is: ",solution)
end

readDataFile("test_input.txt")

readDataFile("input.txt")
function contains_function(code)
    return string.match(code, "function%s+FilterEvenNumbers%s*%(") ~= nil
end

function uses_expected_input(code)
    return string.match(code, "{%s*1%s*,%s*2%s*,%s*3%s*,%s*4%s*,%s*5%s*,%s*6%s*}") ~= nil
end

function calls_function(code)
    return string.match(code, "FilterEvenNumbers%s*%(%s*{") ~= nil
end

function contains_single_output_call(code)
    local print_count = 0
    for _ in code:gmatch("print%s*%(") do print_count = print_count + 1 end

    local write_count = 0
    for _ in code:gmatch("io.write%s*%(") do write_count = write_count + 1 end

    return (print_count + write_count) == 1
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?2%s+4%s+6["\']?%s*%)')
        or string.match(code, 'io.write%s*%(%s*["\']?2%s+4%s+6["\']?%s*%)')
end

function output_is_correct(user_output)
    return user_output:match("^%s*2%s+4%s+6%s*$") ~= nil
end

function split_lines(s)
    local lines = {}
    for line in s:gmatch("[^\r\n]+") do
        table.insert(lines, line:match("^%s*(.-)%s*$"))
    end
    return lines
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 5

    if contains_function(user_code) then
        print("Test 1/5 Passed: Function 'FilterEvenNumbers' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'FilterEvenNumbers' is missing")
    end

    if uses_expected_input(user_code) then
        print("Test 2/5 Passed: Table {1, 2, 3, 4, 5, 6} is used")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Input table is missing or incorrect")
    end

    if calls_function(user_code) then
        print("Test 3/5 Passed: Function is called")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Function is not called")
    end

    if contains_single_output_call(user_code) and not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded and exactly one print/io.write is used")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded or too many output calls")
    end

    local lines = split_lines(user_output)
    if #lines == 1 and output_is_correct(lines[1]) then
        print("Test 5/5 Passed: Output is correct")
        passed = passed + 1
    else
        print("Test 5/5 Failed: Output is incorrect")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)

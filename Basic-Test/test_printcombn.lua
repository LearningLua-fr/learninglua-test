function contains_function_definition(code)
    return string.match(code, "function%s+PrintCombN%s*%(%s*[%w_]+%s*%)") ~= nil
end

function calls_printcombn_with_1(code)
    return string.match(code, "PrintCombN%s*%(%s*1%s*%)") ~= nil
end

function contains_single_print_or_io_write(code)
    local count = 0
    for _ in code:gmatch("print%s*%(") do count = count + 1 end
    for _ in code:gmatch("io.write%s*%(") do count = count + 1 end
    return count >= 1
end

function contains_hardcoded_output(code)
    return code:match('print%s*%(%s*["\']?0, 1, 2, 3, 4, 5, 6, 7, 8, 9["\']?%s*%)') ~= nil
end

function is_expected_output(output)
    local trimmed = output:gsub("^%s*(.-)%s*$", "%1")
    return trimmed == "0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
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

    if contains_function_definition(user_code) then
        print("Test 1/5 Passed: Function 'PrintCombN' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'PrintCombN' is missing")
    end

    if calls_printcombn_with_1(user_code) then
        print("Test 2/5 Passed: Function is called with n = 1")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Function not called with PrintCombN(1)")
    end

    if contains_single_print_or_io_write(user_code) then
        print("Test 3/5 Passed: Code uses print() or io.write()")
        passed = passed + 1
    else
        print("Test 3/5 Failed: No print() or io.write() found")
    end

    if not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
    end

    if is_expected_output(user_output) then
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

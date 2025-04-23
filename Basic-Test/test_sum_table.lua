function contains_function_sumtable(code)
    return string.match(code, "function%s+SumTable%s*%(%s*[%w_]+%s*%)") ~= nil
end

function contains_table_declaration(code)
    return string.match(code, "{%s*10%s*,%s*20%s*,%s*30%s*,%s*40%s*}") ~= nil
end

function calls_sumtable(code)
    return string.match(code, "SumTable%s*%(") ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in string.gmatch(code, "print%s*%(") do
        count = count + 1
    end
    return count == 1
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?100["\']?%s*%)') ~= nil
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
    local total = 6

    if contains_function_sumtable(user_code) then
        print("Test 1/6 Passed: Function 'SumTable' is defined")
        passed = passed + 1
    else
        print("Test 1/6 Failed: Function 'SumTable' is missing")
    end

    if contains_table_declaration(user_code) then
        print("Test 2/6 Passed: Table with values {10, 20, 30, 40} is declared")
        passed = passed + 1
    else
        print("Test 2/6 Failed: Required table is missing or incorrect")
    end

    if calls_sumtable(user_code) then
        print("Test 3/6 Passed: Function 'SumTable' is called")
        passed = passed + 1
    else
        print("Test 3/6 Failed: Function 'SumTable' is not called")
    end

    if contains_single_print(user_code) then
        print("Test 4/6 Passed: Exactly one print() call is used")
        passed = passed + 1
    else
        print("Test 4/6 Failed: Too many or too few print() calls")
    end

    if not contains_hardcoded_output(user_code) then
        print("Test 5/6 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 5/6 Failed: Output is hardcoded")
    end

    local user_lines = split_lines(user_output)
    local expected_lines = split_lines(expected_output_user)
    local output_match = #user_lines == #expected_lines
    for i = 1, #expected_lines do
        if user_lines[i] ~= expected_lines[i] then
            output_match = false
            break
        end
    end

    if output_match then
        print("Test 6/6 Passed: Output is correct")
        passed = passed + 1
    else
        print(string.format("Test 6/6 Failed: Expected '%s', but got '%s'", expected_output_user, user_output))
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)

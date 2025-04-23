function contains_function(code)
    return string.match(code, "function%s+GetInitials%s*%(") ~= nil
end

function calls_function(code)
    return string.match(code, "GetInitials%s*%(%s*['\"]john doe['\"]%s*%)") ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in string.gmatch(code, "print%s*%(") do count = count + 1 end
    return count == 1
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?JD["\']?%s*%)') ~= nil
end

function output_is_correct(user_output)
    return user_output:match("^%s*JD%s*$") ~= nil
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
        print("Test 1/5 Passed: Function 'GetInitials' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'GetInitials' is missing")
    end

    if calls_function(user_code) then
        print("Test 2/5 Passed: Function is called with 'john doe'")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Function not called with 'john doe'")
    end

    if contains_single_print(user_code) then
        print("Test 3/5 Passed: Only one print() call used")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Incorrect number of print() calls")
    end

    if not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
    end

    local output_lines = split_lines(user_output)
    if #output_lines == 1 and output_is_correct(output_lines[1]) then
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

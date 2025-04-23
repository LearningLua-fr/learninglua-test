function contains_function_declaration(code)
    return string.match(code, "function%s+IsPalindrome%s*%(%s*[%w_]+%s*%)") ~= nil
end

function contains_required_tests(code)
    local has_radar     = string.match(code, "IsPalindrome%s*%(%s*['\"]radar['\"]%s*%)")
    local has_plan      = string.match(code, "IsPalindrome%s*%(%s*['\"]A man, a plan, a canal, Panama['\"]%s*%)")
    local has_hello     = string.match(code, "IsPalindrome%s*%(%s*['\"]hello['\"]%s*%)")
    return has_radar and has_plan and has_hello
end

function contains_only_three_prints(code)
    local count = 0
    for _ in string.gmatch(code, "print%s*%(") do
        count = count + 1
    end
    return count == 3
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']true\\ntrue\\nfalse["\']%s*%)') ~= nil
end

function split_lines(s)
    local lines = {}
    for line in s:gmatch("[^\r\n]+") do
        table.insert(lines, line:match("^%s*(.-)%s*$")) -- trim chaque ligne
    end
    return lines
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 4

    if contains_function_declaration(user_code) then
        print("Test 1/4 Passed: Function 'IsPalindrome' is correctly defined")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Function 'IsPalindrome' is missing or incorrect")
    end

    if contains_required_tests(user_code) then
        print("Test 2/4 Passed: Required test cases are present")
        passed = passed + 1
    else
        print("Test 2/4 Failed: Missing one or more required test cases")
    end

    if contains_only_three_prints(user_code) and not contains_hardcoded_output(user_code) then
        print("Test 3/4 Passed: Output is not hardcoded and print count is valid")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Output is hardcoded or too many print() calls")
    end

    local user_lines = split_lines(user_output)
    local expected_lines = split_lines(expected_output_user)

    local output_match = #user_lines == #expected_lines
    for i = 1, #expected_lines do
        if (user_lines[i] or "") ~= (expected_lines[i] or "") then
            output_match = false
            break
        end
    end

    if output_match then
        print("Test 4/4 Passed: Output is correct")
        passed = passed + 1
    else
        print(string.format("Test 4/4 Failed: Expected '%s'", user_output))
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)

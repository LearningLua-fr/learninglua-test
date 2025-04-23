function contains_function_countletter(code)
    return string.match(code, "function%s+CountLetter%s*%(%s*[%w_,%s]+%)") ~= nil
end

function calls_countletter(code)
    return string.match(code, "CountLetter%s*%(%s*['\"]banana['\"]%s*,%s*['\"]a['\"]%s*%)") ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in string.gmatch(code, "print%s*%(") do count = count + 1 end
    return count == 1
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?3["\']?%s*%)') ~= nil
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

    if contains_function_countletter(user_code) then
        print("Test 1/5 Passed: Function 'CountLetter' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'CountLetter' is missing")
    end

    if calls_countletter(user_code) then
        print("Test 2/5 Passed: Function 'CountLetter' is called with 'banana' and 'a'")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Function is not called with correct args")
    end

    if contains_single_print(user_code) then
        print("Test 3/5 Passed: One print() statement used")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Too many or too few print()")
    end

    if not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
    end

    local u = split_lines(user_output)
    local e = split_lines(expected_output_user)
    if #u == #e and u[1] == e[1] then
        print("Test 5/5 Passed: Output is correct")
        passed = passed + 1
    else
        print("Test 5/5 Failed: Expected, got '"..user_output.."'")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end
run_test(user_code, user_output, expected_output_user)

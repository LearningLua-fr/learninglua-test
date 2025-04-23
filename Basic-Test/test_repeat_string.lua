function contains_function(code)
    return string.match(code, "function%s+RepeatString%s*%(%s*[%w_]+%s*,%s*[%w_]+%s*%)") ~= nil
end

function calls_repeat_string(code)
    return string.match(code, "RepeatString%s*%(%s*['\"]Lua['\"]%s*,%s*3%s*%)") ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in code:gmatch("print%s*%(") do count = count + 1 end
    return count == 1
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?LuaLuaLua["\']?%s*%)') ~= nil
end

function output_is_correct(user_output)
    return user_output:match("^%s*LuaLuaLua%s*$") ~= nil
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
        print("Test 1/5 Passed: Function 'RepeatString' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'RepeatString' is missing")
    end

    if calls_repeat_string(user_code) then
        print("Test 2/5 Passed: Function is called with 'Lua', 3")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Function is not called with correct arguments")
    end

    if contains_single_print(user_code) then
        print("Test 3/5 Passed: Only one print() call used")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Too many or too few print() calls")
    end

    if not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
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

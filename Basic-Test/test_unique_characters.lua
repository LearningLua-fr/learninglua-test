function contains_function_definition(code)
    return string.match(code, "function%s+HasUniqueChars%s*%(") ~= nil
end

function calls_with_lua_and_hello(code)
    local call1 = string.match(code, "HasUniqueChars%s*%(%s*['\"]Lua['\"]%s*%)")
    local call2 = string.match(code, "HasUniqueChars%s*%(%s*['\"]hello['\"]%s*%)")
    return call1 and call2
end

function contains_multiple_prints(code)
    local count = 0
    for _ in code:gmatch("print%s*%(") do count = count + 1 end
    return count == 2
end

function output_is_correct(output)
    local clean = output:gsub("\r", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return clean == "true\nfalse"
end

function contains_hardcoded_answer(code)
    return string.match(code, 'print%s*%(%s*["\']true["\']%s*%)') and string.match(code, 'print%s*%(%s*["\']false["\']%s*%)')
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 5

    if contains_function_definition(user_code) then
        print("Test 1/5 Passed: Function 'HasUniqueChars' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'HasUniqueChars' is missing")
    end

    if calls_with_lua_and_hello(user_code) then
        print("Test 2/5 Passed: Function is called with 'Lua' and 'hello'")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Required function calls are missing")
    end

    if contains_multiple_prints(user_code) then
        print("Test 3/5 Passed: Exactly two print() calls found")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Number of print() calls is incorrect")
    end

    if not contains_hardcoded_answer(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded")
    end

    if output_is_correct(user_output) then
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

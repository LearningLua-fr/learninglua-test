function is_expected_output(output)
    return output:gsub("\r", ""):match("^%s*24 12 8 6%s*$") ~= nil
end

function contains_call(code)
    return code:match("arrayProductExceptSelf%s*%(%s*%[1,%s*2,%s*3,%s*4%]%s*%)") ~= nil
end

function contains_function(code)
    return code:match("function%s+arrayProductExceptSelf")
end

function is_output_hardcoded(code)
    -- Vérifie si l'output est directement écrit (hardcoded)
    return code:match('process%.stdout%.write%s*%(%s*["\']24%s+12%s+8%s+6["\']%s*%)') ~= nil
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 4

    if contains_function(user_code) then
        print("Test 1/4 Passed: Function is defined")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Function 'arrayProductExceptSelf' is missing")
    end

    if contains_call(user_code) then
        print("Test 2/4 Passed: Function is called with [1, 2, 3, 4]")
        passed = passed + 1
    else
        print("Test 2/4 Failed: Function call is missing")
    end

    if not user_code:match("console%.log") and not is_output_hardcoded(user_code) then
        print("Test 3/4 Passed: Output is not hardcoded and no console.log")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Output is hardcoded or console.log used")
    end

    if is_expected_output(user_output) then
        print("Test 4/4 Passed: Output is correct")
        passed = passed + 1
    else
        print("Test 4/4 Failed: Output is incorrect")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

-- Execution
run_test(user_code, user_output, expected_output_user)

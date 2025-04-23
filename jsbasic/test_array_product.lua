function is_expected_output(output)
    return output:gsub("\r", ""):match("^%s*24 12 8 6%s*$") ~= nil
end

function contains_call(code)
    return code:match("arrayProductExceptSelf%s*%(%s*%[1, 2, 3, 4%]%s*%)")
end

function contains_function(code)
    return code:match("function%s+arrayProductExceptSelf")
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0

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

    if not user_code:match("24%s+12%s+8%s+6") and not user_code:match("console%.log") then
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

    if passed == 4 then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end


run_test(user_code, user_output, expected_output_user)
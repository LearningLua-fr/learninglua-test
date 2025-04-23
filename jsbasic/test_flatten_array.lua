function contains_function(code)
    return code:match("function%s+flatten")
end

function contains_call(code)
    return code:match("flatten%s*%(%s*%[1,%s*%[2,%s*%[3, 4%]%]%s*,%s*5%]%s*%)")
end

function output_is_correct(output)
    return output:match("^%s*1%s+2%s+3%s+4%s+5%s*$") ~= nil
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0

    if contains_function(user_code) then
        print("Test 1/4 Passed: Function 'flatten' is defined")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Function is missing")
    end

    if contains_call(user_code) then
        print("Test 2/4 Passed: flatten([1, [2, [3, 4]], 5]) is called")
        passed = passed + 1
    else
        print("Test 2/4 Failed: Required function call is missing")
    end

    if not user_code:match("console%.log") and not user_code:match("1%s+2%s+3%s+4%s+5") then
        print("Test 3/4 Passed: Output is not hardcoded and no console.log")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Output is hardcoded or console.log used")
    end

    if output_is_correct(user_output) then
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
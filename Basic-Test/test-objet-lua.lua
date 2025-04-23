function contains_user_table(code)
    return string.match(code, "User%s*=%s*{}") ~= nil
end

function contains_user_new_method(code)
    return string.match(code, "function%s+User:new%s*%(%s*[%w_]+%s*%)") ~= nil
end

function contains_sayhello_method(code)
    return string.match(code, "function%s+User:sayHello%s*%(") ~= nil
end

function creates_user_instance(code)
    return string.match(code, "User:new%s*%(%s*['\"]Alice['\"]%s*%)") ~= nil
end

function calls_sayhello_method(code)
    return string.match(code, ":%s*sayHello%s*%(%s*%)") ~= nil
end

function contains_hardcoded_hello(code)
    return string.match(code, 'print%s*%(%s*["\']Hello, my name is Alice["\']%s*%)') ~= nil
end

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 6

    if contains_user_table(user_code) then
        print("Test 1/6 Passed: Object 'User' is declared")
        passed = passed + 1
    else
        print("Test 1/6 Failed: Object 'User' is missing")
    end

    if contains_user_new_method(user_code) then
        print("Test 2/6 Passed: Constructor 'User:new()' is defined")
        passed = passed + 1
    else
        print("Test 2/6 Failed: Constructor 'User:new()' is missing")
    end

    if contains_sayhello_method(user_code) then
        print("Test 3/6 Passed: Method 'sayHello()' is defined")
        passed = passed + 1
    else
        print("Test 3/6 Failed: Method 'sayHello()' is missing")
    end

    if creates_user_instance(user_code) then
        print("Test 4/6 Passed: User object is created with name 'Alice'")
        passed = passed + 1
    else
        print("Test 4/6 Failed: User object creation with name 'Alice' is missing")
    end

    if calls_sayhello_method(user_code) then
        print("Test 5/6 Passed: Method 'sayHello()' is called")
        passed = passed + 1
    else
        print("Test 5/6 Failed: Method 'sayHello()' is not called")
    end

    if not contains_hardcoded_hello(user_code) and trim(user_output) == trim(expected_output_user) then
        print("Test 6/6 Passed: Output is correct and not hardcoded")
        passed = passed + 1
    else
        print("Test 6/6 Failed: Output is incorrect or hardcoded")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)

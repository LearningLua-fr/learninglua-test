function contains_user_table(code)
    return string.match(code, "User%s*=%s*{}") ~= nil
end

function contains_user_new_method(code)
    return string.match(code, "function%s+User:new%s*%(%s*[%w_]+%s*,%s*[%w_]+%s*%)") ~= nil
end

function contains_sayhello_method(code)
    return string.match(code, "function%s+User:sayHello%s*%(") ~= nil
end

function creates_user_instance_with_age(code)
    return string.match(code, "User:new%s*%(%s*['\"]Alice['\"]%s*,%s*30%s*%)") ~= nil
end

function calls_sayhello_method(code)
    return string.match(code, ":%s*sayHello%s*%(%s*%)") ~= nil
end

function contains_hardcoded_full_output(code)
    return string.match(code, 'print%s*%(%s*["\']Hello, my name is Alice and I am 30 years old["\']%s*%)') ~= nil
end

function output_contains_name_and_age(user_output)
    return user_output:find("Alice") and user_output:find("30")
end

function split_lines(s)
    local lines = {}
    for line in s:gmatch("[^\r\n]+") do
        table.insert(lines, line:match("^%s*(.-)%s*$")) -- trim each line
    end
    return lines
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
        print("Test 2/6 Passed: Constructor 'User:new(name, age)' is defined")
        passed = passed + 1
    else
        print("Test 2/6 Failed: Constructor 'User:new(name, age)' is missing or incorrect")
    end

    if contains_sayhello_method(user_code) then
        print("Test 3/6 Passed: Method 'sayHello()' is defined")
        passed = passed + 1
    else
        print("Test 3/6 Failed: Method 'sayHello()' is missing")
    end

    if creates_user_instance_with_age(user_code) then
        print("Test 4/6 Passed: User object is created with name 'Alice' and age 30")
        passed = passed + 1
    else
        print("Test 4/6 Failed: Object instantiation with name 'Alice' and age 30 is missing or incorrect")
    end

    if calls_sayhello_method(user_code) then
        print("Test 5/6 Passed: Method 'sayHello()' is called")
        passed = passed + 1
    else
        print("Test 5/6 Failed: Method 'sayHello()' is not called")
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

    if not contains_hardcoded_full_output(user_code) and output_match and output_contains_name_and_age(user_output) then
        print("Test 6/6 Passed: Output is correct and not hardcoded")
        passed = passed + 1
    else
        print("Test 6/6 Failed: Output is incorrect, incomplete, or hardcoded")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)

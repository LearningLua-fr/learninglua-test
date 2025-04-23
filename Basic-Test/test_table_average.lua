function contains_function(code)
    return string.match(code, "function%s+TableAverage%s*%(%s*[%w_]+%s*%)") ~= nil
end

function uses_table_10_20_30(code)
    return string.match(code, "{%s*10%s*,%s*20%s*,%s*30%s*}") ~= nil
end

function calls_tableaverage(code)
    return string.match(code, "TableAverage%s*%(%s*[{]") ~= nil
end

function contains_hardcoded_output(code)
    return string.match(code, 'print%s*%(%s*["\']?20%.00["\']?%s*%)') ~= nil
end

function contains_single_print(code)
    local count = 0
    for _ in code:gmatch("print%s*%(") do count = count + 1 end
    return count == 1
end

function output_is_correct(user_output)
    return user_output:match("^%s*20%.00%s*$") ~= nil
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
        print("Test 1/5 Passed: Function 'TableAverage' is defined")
        passed = passed + 1
    else
        print("Test 1/5 Failed: Function 'TableAverage' is missing")
    end

    if uses_table_10_20_30(user_code) then
        print("Test 2/5 Passed: Table {10, 20, 30} is used")
        passed = passed + 1
    else
        print("Test 2/5 Failed: Table {10, 20, 30} is missing or incorrect")
    end

    if calls_tableaverage(user_code) then
        print("Test 3/5 Passed: Function 'TableAverage' is called")
        passed = passed + 1
    else
        print("Test 3/5 Failed: Function 'TableAverage' is not called")
    end

    if contains_single_print(user_code) and not contains_hardcoded_output(user_code) then
        print("Test 4/5 Passed: Output is not hardcoded and printed once")
        passed = passed + 1
    else
        print("Test 4/5 Failed: Output is hardcoded or too many print() used")
    end

    local output_lines = split_lines(user_output)
    if #output_lines == 1 and output_is_correct(output_lines[1]) then
        print("Test 5/5 Passed: Output is correct")
        passed = passed + 1
    else
        print(string.format("Test 5/5 Failed: Output incorrect (got '%s')", user_output))
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end
run_test(user_code, user_output, expected_output_user)

function contains_table_declaration(code)
    return string.match(code, "local%s+myTable%s*=%s*{}") ~= nil
end

function contains_table_insert(code)
    return string.match(code, "table%.insert%s*%(%s*myTable%s*,%s*[%w_]+%s*%)") ~= nil
end

function contains_loop(code)
    return string.match(code, "for%s+[%w_]+%s*=%s*1%s*,%s*#myTable") ~= nil or
           string.match(code, "for%s+[%w_]+%s*,%s*[%w_]+%s+in%s+ipairs%s*%(%s*myTable%s*%)") ~= nil
end

function contains_dynamic_print(code)
    return string.match(code, "print%s*%(%s*[%w_]+%s*%)") ~= nil
end

function run_test(user_code)
    local passed = 0
    local total = 4

    if contains_table_declaration(user_code) then
        print("Test 1/4 Passed: Table 'myTable' is correctly defined as empty")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Table 'myTable' is missing or not correctly defined")
    end

    if contains_table_insert(user_code) then
        print("Test 2/4 Passed: Elements are inserted using 'table.insert'")
        passed = passed + 1
    else
        print("Test 2/4 Failed: 'table.insert' is missing or incorrect")
    end

    if contains_loop(user_code) then
        print("Test 3/4 Passed: A valid loop is defined to iterate over the table")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Loop is missing or incorrect")
    end

    if contains_dynamic_print(user_code) then
        print("Test 4/4 Passed: Values are printed dynamically inside the loop")
        passed = passed + 1
    else
        print("Test 4/4 Failed: Dynamic print statement is missing or incorrect")
    end

    if passed == total then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code) 

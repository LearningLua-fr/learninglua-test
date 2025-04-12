local function contains_forbidden_output(code)
    local forbidden_patterns = {
        'print%s*%(%s*["\']Bonjour["\']%s*%)',
        'console%.log%s*%(%s*["\']Bonjour["\']%s*%)',
        '["\']Bonjour["\']'
    }

    for _, pattern in ipairs(forbidden_patterns) do
        if string.match(code, pattern) then
            return true
        end
    end

    return false
end

local function normalize_string(str)
    return string.gsub(str or "", "%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

local function file_exists(filename)
    local f = io.open(filename, "r")
    if f then f:close() return true else return false end
end

local function read_file(filename)
    local f = io.open(filename, "r")
    if not f then return nil end
    local content = f:read("*all")
    f:close()
    return content
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if contains_forbidden_output(user_code) then
        print("❌ Test 1/5: Forbidden direct string 'Bonjour' used.")
        passed = false
    else
        print("✅ Test 1/5: No forbidden direct output detected.")
    end

    if file_exists("input.txt") then
        print("✅ Test 2/5: 'input.txt' exists.")
    else
        print("❌ Test 2/5: 'input.txt' not found.")
        passed = false
    end

    local file_content = read_file("input.txt")
    if normalize_string(file_content) == "Bonjour" then
        print("✅ Test 3/5: 'input.txt' contains 'Bonjour'.")
    else
        print("❌ Test 3/5: 'input.txt' content incorrect.")
        passed = false
    end

    if normalize_string(user_output) == "Bonjour" then
        print("✅ Test 4/5: Output is 'Bonjour'.")
    else
        print("❌ Test 4/5: Output mismatch.")
        passed = false
    end

    if normalize_string(user_output) == normalize_string(expected_output_user) then
        print("✅ Test 5/5: Final output matches expected.")
    else
        print("❌ Test 5/5: Final output doesn't match expected.")
        passed = false
    end

    if passed then
        print("🎉 All tests passed.")
    else
        print("🔁 Some tests failed.")
    end
end

-- Appel du test
run_test(user_code, user_output, expected_output_user)

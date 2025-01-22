local function contains_no_change(code)
    return string.match(code, "const%s+NO_CHANGE%s*=%s*25%s*;") ~= nil
end

local function contains_change_me(code)
    return string.match(code, "let%s+CHANGE_ME%s*=%s*0%s*;") ~= nil
        or string.match(code, "var%s+CHANGE_ME%s*=%s*0%s*;") ~= nil
end

local function normalize_string(str)
    local normalized = string.gsub(str, "%s+", " ")
    normalized = string.gsub(normalized, "^%s*(.-)%s*$", "%1")
    return normalized
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

local function run_test(user_code, user_output, expected_output_user)
    if contains_no_change(user_code) then
        print("Test Passed 1/2: 'NO_CHANGE' is correctly declared as 25.")
    else
        print("Test Failed 1/2: 'NO_CHANGE' is not correctly declared as 25.")
    end

  if contains_change_me(user_code) then
        print("Test Passed 2/2: 'CHANGE_ME' is correctly declared as 0.")
    else
        print("Test Failed 2/2: 'CHANGE_ME' is not correctly declared as 0.")
    end

    if contains_no_change(user_code) and contains_change_me(user_code) then
        print("All tests passed.")
    else
        print("Some tests failed. Please review your code.")
    end
end

run_test(user_code, user_output, expected_output_user)


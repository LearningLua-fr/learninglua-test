-- Fonction pour exécuter le code utilisateur sans montrer de détails
function execute_user_code(user_code)
    local func, err = load(user_code)
    if func then
        return pcall(func)
    else
        return false, err
    end
end

-- Fonction de test avec vérification de la table sans afficher les détails
function run_test(step_description, user_code, validation_function)
    local success, _ = execute_user_code(user_code)
    if success and validation_function() then
        print(step_description .. " : Test Passed!")
    else
        print(step_description .. " : Test Failed!")
    end
end

-- Tests de validation des données dans la table sans exposer la structure

-- Test 1 : Vérification de la présence de 2 éléments dans la table
function check_table_length()
    return #people == 2
end
run_test("Step 1: Vérification du nombre d'éléments", user_code, check_table_length)

-- Test 2 : Vérification des valeurs du premier élément (nom, âge, travail)
function check_first_person_values()
    local first_person = people[1]
    return first_person.name == "Max" and first_person.age == 25 and first_person.job == "Developer"
end
run_test("Step 2: Vérification des données du premier élément", user_code, check_first_person_values)

-- Test 3 : Vérification des valeurs du deuxième élément
function check_second_person_values()
    local second_person = people[2]
    return second_person.name == "Jenna" and second_person.age == 30 and second_person.job == "Designer"
end
run_test("Step 3: Vérification des données du deuxième élément", user_code, check_second_person_values)

-- Test 4 : Vérification de l'ajout d'un troisième élément
function check_third_person_addition()
    table.insert(people, {name = "Alice", age = 28, job = "Artist"})
    return #people == 3 and people[3].name == "Alice" and people[3].age == 28 and people[3].job == "Artist"
end
run_test("Step 4: Vérification de l'ajout d'un troisième élément", user_code, check_third_person_addition)

-- Test 5 : Vérification de la suppression d'un élément
function check_removal_of_person()
    table.remove(people, 2) -- Suppression de la deuxième personne (Jenna)
    return #people == 2 and people[1].name == "Max" and people[2].name == "Alice"
end
run_test("Step 5: Vérification de la suppression du deuxième élément", user_code, check_removal_of_person)

-- Test 6 : Vérification de l'absence de `print` explicite avec les données spécifiques
function check_forbidden_prints(user_code)
    local forbidden_patterns = {
        "print%(%s*\"Max\"%s*%)",         -- Vérifie un print avec "Max"
        "print%(%s*\"25\"%s*%)",          -- Vérifie un print avec "25"
        "print%(%s*\"Developer\"%s*%)",   -- Vérifie un print avec "Developer"
        "print%(%s*\"Jenna\"%s*%)",       -- Vérifie un print avec "Jenna"
        "print%(%s*\"30\"%s*%)",          -- Vérifie un print avec "30"
        "print%(%s*\"Designer\"%s*%)"     -- Vérifie un print avec "Designer"
    }

    -- Boucle sur chaque motif et vérifie s'il existe dans le code utilisateur
    for _, pattern in ipairs(forbidden_patterns) do
        if string.match(user_code, pattern) then
            return false  -- Échoue si un pattern interdit est trouvé
        end
    end
    return true  -- Passe si aucun print explicite interdit n'est trouvé
end
run_test("Step 6: Vérification de l'absence de prints explicites interdits", user_code, function() return check_forbidden_prints(user_code) end)

-- Test 7 : Vérification que le code produit la sortie correcte sans print explicite
function check_output_and_forbidden_prints(user_code)
    -- D'abord, on s'assure que les `print` explicites sont interdits
    local no_forbidden_prints = check_forbidden_prints(user_code)
    
    -- Ensuite, on vérifie que le code produit la sortie attendue
    local success, output = execute_user_code(user_code)
    
    -- Remplace les retours à la ligne et espaces pour faciliter la comparaison
    function normalizeOutput(output)
        return output:gsub("%s+", " "):gsub("\n", " "):trim()
    end

    local expected_output = "Name: Max Age: 25 Job: Developer Name: Jenna Age: 30 Job: Designer"
    local output_is_correct = (normalizeOutput(output) == expected_output)

    return no_forbidden_prints and output_is_correct
end
run_test("Step 7: Vérification que le code produit la sortie correcte sans print explicite", user_code, check_output_and_forbidden_prints)

require("automaton")

local states = {
    'a', 'b', 'c'
};

local alphabet = {
    '0', '1'
};

local transitionFunction = {
    ['a'] = {
        ['0'] = 'b',
        ['1'] = 'a'
    },
    ['b'] = {
        ['0'] = 'a',
        ['1'] = 'b'
    }
}

local initialState = 'a';
local endState = {'b'};

local automaton = FiniteAutomatonDeterministic:create(states, alphabet, 
                                                        transitionFunction, initialState, endState);

print(automaton.checkstring(automaton, '010'))
print(automaton.checkstring(automaton, '0100'))

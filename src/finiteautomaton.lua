require('utils')

FiniteAutomatonDeterministic = {}
FiniteAutomatonDeterministic.__index = FiniteAutomatonDeterministic

function FiniteAutomatonDeterministic:create(states, alphabet, transitionFunction, initialState, endStates)
    local this = {
        states = states,
        alphabet = alphabet,
        endStates = endStates,
        actualState = initialState,
        initialState = initialState,
        transitionFunction = transitionFunction
    }
    setmetatable(this, FiniteAutomatonDeterministic)
    return this
end

function FiniteAutomatonDeterministic.checkstring(self, stringW)
    local stringIsValid = false;

    for index=1, #stringW do
        self.changestate(self, stringW:sub(index, index));
    end
    
    if valueIsInArray(self.actualState, self.endStates) then
        self.actualState = self.initialState;
        stringIsValid = true;
    end
    return stringIsValid;
end

function FiniteAutomatonDeterministic.changestate(self, alphabetSymbol)
    if valueIsInArray(alphabetSymbol, self.alphabet) then
        self.actualState = self.transitionFunction[self.actualState][alphabetSymbol];
    else
        error("Symbol is not in Automaton Alphabet");
    end
end

-- Test code
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

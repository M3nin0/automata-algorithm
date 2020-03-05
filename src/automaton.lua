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
